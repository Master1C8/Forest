/* Forest macOS adapter. Reuse the validated decoder/envelope implementation.
 * Encode only the new serialized member and the first partial stream block;
 * retain every remaining original encoded stream block unchanged. */
#define main forest_shared_codec_main
#include "../Windows/forest_bundle.c"
#undef main
#include <zlib.h>
static void put(FILE *f,uint64_t value,int n) { while(n--) { unsigned char c=(unsigned char)(value>>(n*8));write_exact(f,&c,1); } }
static void text(FILE *f,const char *s) { write_exact(f,s,strlen(s)+1); }
static Block encode_block(FILE *out,unsigned char *raw,uint32_t count) {
    unsigned char packed[LZ4_COMPRESSBOUND(131072)];
    int n=LZ4_compress_HC((char*)raw,(char*)packed,(int)count,sizeof packed,9);
    Block block={count,count,0};
    if(n>0 && n<(int)count){block.packed=(uint32_t)n;block.flags=2;write_exact(out,packed,(size_t)n);}
    else write_exact(out,raw,count);
    return block;
}
int main(int argc,char **argv) {
    if(argc!=5 || strcmp(argv[1],"compose"))return forest_shared_codec_main(argc,argv);
    Source source=source_open(argv[2]);
    FILE *asset=fopen(argv[3],"rb"),*out=fopen(argv[4],"w+b");need(asset && out,"Bundle input/output unavailable");
    need(fseek(asset,0,SEEK_END)==0,"Asset seek failed");long asset_size=ftell(asset);need(asset_size>0 && asset_size<536870912,"Asset size exceeds bound");rewind(asset);
    uint32_t capacity=(uint32_t)(asset_size/131072+source.count+4);Block *blocks=calloc(capacity,sizeof(Block));need(blocks!=NULL,"Out of memory");uint32_t count=0;
    text(out,"UnityFS");put(out,7,4);text(out,"5.x.x");text(out,"2020.3.24f1");long size_pos=ftell(out);put(out,0,8);put(out,0,4);put(out,0,4);put(out,192,4);
    while(ftell(out)%16)put(out,0,1);
    unsigned char buffer[131072];long left=asset_size;uLong crc=crc32(0L,Z_NULL,0);
    while(left){uint32_t n=left>(long)sizeof buffer?sizeof buffer:(uint32_t)left;read_exact(asset,buffer,n);crc=crc32(crc,buffer,n);blocks[count++]=encode_block(out,buffer,n);left-=n;}
    source_read(&source,NULL,(size_t)source.asset_size);
    uint32_t prefix=(uint32_t)(source.have-source.cursor),tail_index=source.index;long tail_offset=ftell(source.file);
    if(prefix)memcpy(buffer,source.raw+source.cursor,prefix);
    // CRC is over the complete contiguous uncompressed member stream.
    uint64_t remaining=source.stream_size;
    while(remaining){size_t n=remaining>65536?65536:(size_t)remaining;unsigned char piece[65536];source_read(&source,piece,n);crc=crc32(crc,piece,(uInt)n);remaining-=n;}
    if(prefix)blocks[count++]=encode_block(out,buffer,prefix);
    need(fseek(source.file,tail_offset,SEEK_SET)==0,"Original tail seek failed");
    for(uint32_t i=tail_index;i<source.count;++i){blocks[count++]=source.blocks[i];copy(source.file,out,source.blocks[i].packed);}
    long info_start=ftell(out);unsigned char zero[16]={0};write_exact(out,zero,16);put(out,count,4);
    for(uint32_t i=0;i<count;++i){put(out,blocks[i].raw,4);put(out,blocks[i].packed,4);put(out,blocks[i].flags,2);}
    put(out,2,4);put(out,0,8);put(out,(uint64_t)asset_size,8);put(out,4,4);text(out,"CAB-7cd732d37ea0297d073a22a52ce72d28");
    put(out,(uint64_t)asset_size,8);put(out,source.stream_size,8);put(out,0,4);text(out,"CAB-7cd732d37ea0297d073a22a52ce72d28.resS");
    long end=ftell(out),info_size=end-info_start;need(fseek(out,size_pos,SEEK_SET)==0,"Header seek failed");put(out,(uint64_t)end,8);put(out,(uint64_t)info_size,4);put(out,(uint64_t)info_size,4);
    need(fclose(out)==0,"Bundle close failed");fclose(asset);source_close(&source);free(blocks);
    printf("{\"bytes\":%ld,\"crc32\":%lu,\"contiguousMembers\":true,\"originalEncodedTailPreserved\":true}\n",end,(unsigned long)crc);return 0;
}
