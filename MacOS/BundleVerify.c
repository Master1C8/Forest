/* Independent streaming readback: exact serialized bytes, complete native
 * streaming member and Unity CRC. Does not start or load the Unity player. */
#define main forest_shared_codec_main
#include "../Windows/forest_bundle.c"
#undef main
#include <zlib.h>
int main(int argc,char **argv) {
    need(argc==4,"verify original.bundle expected.asset produced.bundle");
    Source original=source_open(argv[1]),target=source_open(argv[3]);
    FILE *asset=fopen(argv[2],"rb");need(asset!=NULL,"Expected asset unavailable");
    need(fseek(asset,0,SEEK_END)==0 && ftell(asset)==(long)target.asset_size && fseek(asset,0,SEEK_SET)==0,"Serialized size mismatch");
    unsigned char a[65536],b[65536];uint64_t left=target.asset_size;uLong crc=crc32(0L,Z_NULL,0);
    while(left){size_t n=left>sizeof a?sizeof a:(size_t)left;source_read(&target,a,n);read_exact(asset,b,n);need(!memcmp(a,b,n),"Serialized bytes differ");crc=crc32(crc,a,(uInt)n);left-=n;}
    need(target.stream_size==original.stream_size,"Native streaming size changed");source_read(&original,NULL,(size_t)original.asset_size);left=target.stream_size;
    while(left){size_t n=left>sizeof a?sizeof a:(size_t)left;source_read(&target,a,n);source_read(&original,b,n);need(!memcmp(a,b,n),"Native streaming bytes changed");crc=crc32(crc,a,(uInt)n);left-=n;}
    printf("{\"serializedExact\":true,\"completeNativeStreamExact\":true,\"crc32\":%lu,\"streamBytes\":%llu}\n",(unsigned long)crc,(unsigned long long)target.stream_size);
    fclose(asset);source_close(&original);source_close(&target);return 0;
}
