/* Lossless UnityFS storage adapter. Only the first serialized member changes;
 * the second member is streamed from the player's verified original bundle.
 * Every produced file is SHA-256 checked by the installer before any game write.
 */
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "lz4.h"
#include "lz4hc.h"
#include "LzmaDec.h"

typedef struct { uint32_t raw, packed; uint16_t flags; } Block;
typedef struct {
    FILE *file; Block *blocks; uint32_t count, index;
    uint64_t asset_size, stream_size;
    unsigned char *raw, *packed; size_t have, cursor;
} Source;
static void fail(const char *s) { fprintf(stderr, "%s\n", s); exit(1); }
static void need(int good, const char *s) { if (!good) fail(s); }
static void read_exact(FILE *f, void *p, size_t n) { need(fread(p, 1, n, f) == n, "Truncated input"); }
static void write_exact(FILE *f, const void *p, size_t n) { need(fwrite(p, 1, n, f) == n, "Output write failed"); }
static uint64_t be(FILE *f, int n) { uint64_t v=0; while(n--) { int c=fgetc(f); need(c!=EOF,"Truncated number"); v=(v<<8)|(unsigned)c; } return v; }
static void string(FILE *f, char *s, size_t n) { size_t i=0; for (;;) { int c=fgetc(f); need(c!=EOF && i+1<n,"Invalid string"); s[i++]=(char)c; if(!c) return; } }
static uint64_t number(const unsigned char **p, const unsigned char *end, int n) {
    need(end-*p>=n,"Truncated metadata"); uint64_t v=0; while(n--) v=(v<<8)|*(*p)++; return v;
}
static void skip_string(const unsigned char **p, const unsigned char *end) { while (*p<end && *(*p)++) { } need(*p<=end && (*p)[-1]==0,"Invalid member name"); }
static Source source_open(const char *path) {
    Source s={0}; s.file=fopen(path,"rb"); need(s.file!=NULL,"Original bundle unavailable");
    char word[256]; string(s.file,word,sizeof word); need(!strcmp(word,"UnityFS"),"Expected UnityFS");
    uint32_t version=(uint32_t)be(s.file,4); need(version==7,"Unsupported UnityFS version");
    string(s.file,word,sizeof word); string(s.file,word,sizeof word);
    uint64_t size=be(s.file,8); uint32_t packed_info=(uint32_t)be(s.file,4), raw_info=(uint32_t)be(s.file,4), flags=(uint32_t)be(s.file,4);
    need(size<2147483647 && raw_info>20 && raw_info<4000000 && packed_info<4000000 && !(flags&0x200),"Invalid original metadata bounds");
    long pos=ftell(s.file); need(pos>0,"Invalid header"); long start=(pos+15)&~15L;
    need(size>=packed_info,"Metadata exceeds input");
    need(fseek(s.file,(flags&128)?(long)(size-packed_info):start,SEEK_SET)==0,"Metadata seek failed");
    unsigned char *packed=malloc(packed_info), *raw=malloc(raw_info); need(packed && raw,"Out of memory");
    read_exact(s.file,packed,packed_info);
    if ((flags&63)==0) { need(packed_info==raw_info,"Invalid raw metadata"); memcpy(raw,packed,raw_info); }
    else { need((flags&63)==2 || (flags&63)==3,"Unsupported metadata compression"); need(LZ4_decompress_safe((char*)packed,(char*)raw,(int)packed_info,(int)raw_info)==(int)raw_info,"Metadata decompression failed"); }
    free(packed); const unsigned char *p=raw+16,*end=raw+raw_info;
    s.count=(uint32_t)number(&p,end,4); need(s.count>0 && s.count<20000,"Invalid block count");
    s.blocks=calloc(s.count,sizeof(Block)); need(s.blocks!=NULL,"Out of memory");
    uint64_t total=0; uint32_t max_raw=0,max_packed=0;
    for(uint32_t i=0;i<s.count;++i) {
        Block *b=&s.blocks[i]; b->raw=(uint32_t)number(&p,end,4); b->packed=(uint32_t)number(&p,end,4); b->flags=(uint16_t)number(&p,end,2);
        need(b->raw>0 && b->raw<=4194304 && b->packed>0 && b->packed<=5000000,"Invalid source block bounds");
        total+=b->raw; if(b->raw>max_raw)max_raw=b->raw; if(b->packed>max_packed)max_packed=b->packed;
    }
    need(number(&p,end,4)==2,"Expected two original members");
    need(number(&p,end,8)==0,"Invalid asset offset"); s.asset_size=number(&p,end,8); (void)number(&p,end,4); skip_string(&p,end);
    need(number(&p,end,8)==s.asset_size,"Noncontiguous original members"); s.stream_size=number(&p,end,8); (void)number(&p,end,4); skip_string(&p,end);
    need(p==end && total==s.asset_size+s.stream_size && s.asset_size<536870912 && total<2147483647,"Invalid original member bounds");
    free(raw); s.raw=malloc(max_raw); s.packed=malloc(max_packed); need(s.raw && s.packed,"Out of memory");
    if (!(flags&128)) start+=(long)packed_info;
    need(fseek(s.file,start,SEEK_SET)==0,"Data seek failed"); return s;
}
static void source_read(Source *s, unsigned char *out, size_t n) {
    while(n) {
        if(s->cursor==s->have) {
            need(s->index<s->count,"Original stream exhausted"); Block b=s->blocks[s->index++]; read_exact(s->file,s->packed,b.packed);
            if((b.flags&63)==0) { need(b.raw==b.packed,"Invalid raw source block"); memcpy(s->raw,s->packed,b.raw); }
            else { need((b.flags&63)==2 || (b.flags&63)==3,"Unsupported source compression"); need(LZ4_decompress_safe((char*)s->packed,(char*)s->raw,(int)b.packed,(int)b.raw)==(int)b.raw,"Source decompression failed"); }
            s->have=b.raw; s->cursor=0;
        }
        size_t take=s->have-s->cursor; if(take>n)take=n;
        if(out) { memcpy(out,s->raw+s->cursor,take); out+=take; }
        s->cursor+=take; n-=take;
    }
}
static void source_close(Source *s) { fclose(s->file); free(s->blocks); free(s->raw); free(s->packed); }
static void copy(FILE *in, FILE *out, uint64_t count) { unsigned char b[65536]; while(count) { size_t n=count>sizeof b?sizeof b:(size_t)count;read_exact(in,b,n);write_exact(out,b,n);count-=n; } }
static void *lz_alloc(ISzAllocPtr p,size_t n) { (void)p;return malloc(n); }
static void lz_free(ISzAllocPtr p,void *v) { (void)p;free(v); }
static const ISzAlloc allocator={lz_alloc,lz_free};
static int inflate_package(const char *input,const char *output) {
    FILE *in=fopen(input,"rb"),*out=fopen(output,"wb");need(in && out,"Package files unavailable");
    char magic[8],hash[64];read_exact(in,magic,8);need(!memcmp(magic,"FRSTPKG1",8),"Invalid package envelope");
    uint64_t remaining=be(in,8);need(remaining>0 && remaining<2147483647,"Invalid decoded package size");read_exact(in,hash,64);
    Byte header[13];read_exact(in,header,sizeof header);CLzmaProps props;
    need(LzmaProps_Decode(&props,header,5)==SZ_OK && props.dicSize<=268435456,"Invalid package dictionary");
    CLzmaDec decoder;LzmaDec_Construct(&decoder);
    need(LzmaDec_Allocate(&decoder,header,5,&allocator)==SZ_OK,"Package decoder allocation failed");LzmaDec_Init(&decoder);
    Byte encoded[65536],decoded[65536];size_t position=0,size=0;
    while(remaining) {
        if(position==size) { size=fread(encoded,1,sizeof encoded,in);position=0;need(!ferror(in),"Package read failed"); }
        SizeT used=size-position,produced=remaining<sizeof decoded?(SizeT)remaining:sizeof decoded;
        ELzmaStatus status;ELzmaFinishMode finish=remaining<=sizeof decoded?LZMA_FINISH_END:LZMA_FINISH_ANY;
        SRes result=LzmaDec_DecodeToBuf(&decoder,decoded,&produced,encoded+position,&used,finish,&status);
        need(result==SZ_OK && (used || produced),"Damaged or truncated compressed package");
        position+=used;write_exact(out,decoded,produced);remaining-=produced;
    }
    LzmaDec_Free(&decoder,&allocator);need(fclose(out)==0,"Closing decoded package failed");fclose(in);return 0;
}
int main(int argc,char **argv) {
    need(argc==4 || argc==6,"Invalid codec arguments");
    if(argc==4 && !strcmp(argv[1],"inflate")) return inflate_package(argv[2],argv[3]);
    Source s=source_open(argv[2]);
    if(!strcmp(argv[1],"extract") && argc==4) {
        FILE *out=fopen(argv[3],"wb");need(out!=NULL,"Cannot create asset output");
        uint64_t left=s.asset_size; unsigned char b[65536];
        while(left) { size_t n=left>sizeof b?sizeof b:(size_t)left;source_read(&s,b,n);write_exact(out,b,n);left-=n; }
        need(fclose(out)==0,"Closing asset output failed"); source_close(&s); return 0;
    }
    need(!strcmp(argv[1],"pack") && argc==6,"Unknown codec command");
    FILE *asset=fopen(argv[3],"rb"), *recipe=fopen(argv[4],"rb"), *out=fopen(argv[5],"wb");need(asset && recipe && out,"Codec file unavailable");
    char magic[8];read_exact(recipe,magic,8);need(!memcmp(magic,"FRSTBND1",8),"Invalid bundle recipe");
    uint32_t prefix=(uint32_t)be(recipe,4),suffix=(uint32_t)be(recipe,4),count=(uint32_t)be(recipe,4);uint64_t asset_left=be(recipe,8);
    need(prefix<=4000000 && suffix<=4000000 && count>0 && count<20000 && asset_left<536870912,"Invalid target bounds");
    need(fseek(asset,0,SEEK_END)==0 && ftell(asset)==(long)asset_left && fseek(asset,0,SEEK_SET)==0,"Asset input size mismatch");
    source_read(&s,NULL,(size_t)s.asset_size); copy(recipe,out,prefix);
    unsigned char raw[131072], packed[LZ4_COMPRESSBOUND(131072)];
    /* ResS has long runs of identical zero blocks. Reuse only after a complete
     * byte comparison; this changes no compression decision or output byte. */
    unsigned char previous_raw[131072]; uint32_t previous_size=0,previous_packed=0;uint16_t previous_flags=0;
    uint64_t stream_left=s.stream_size;
    for(uint32_t i=0;i<count;++i) {
        uint32_t raw_size=(uint32_t)be(recipe,4),packed_size=(uint32_t)be(recipe,4);uint16_t flags=(uint16_t)be(recipe,2);unsigned mode=(unsigned)be(recipe,1);
        need(raw_size>0 && raw_size<=sizeof raw && packed_size>0 && packed_size<=sizeof packed && mode<=2,"Invalid target block");
        size_t take=asset_left<raw_size?(size_t)asset_left:raw_size;
        read_exact(asset,raw,take); asset_left-=take;
        need(raw_size-take<=stream_left,"Target stream exceeds original");source_read(&s,raw+take,raw_size-take);stream_left-=raw_size-take;
        if(mode==2) copy(recipe,out,packed_size);
        else if((flags&63)==0) { need(mode==0 && raw_size==packed_size,"Invalid raw target block");write_exact(out,raw,raw_size); }
        else {
            need(mode==1 && ((flags&63)==2 || (flags&63)==3),"Invalid target compression");
            int n;
            if(previous_size==raw_size && previous_packed==packed_size && previous_flags==flags && !memcmp(raw,previous_raw,raw_size)) n=(int)previous_packed;
            else {
                n=LZ4_compress_HC((char*)raw,(char*)packed,(int)raw_size,sizeof packed,9);
                memcpy(previous_raw,raw,raw_size);previous_size=raw_size;previous_packed=(uint32_t)n;previous_flags=flags;
            }
            need(n==(int)packed_size,"Deterministic LZ4 size mismatch");write_exact(out,packed,(size_t)n);
        }
    }
    need(asset_left==0 && stream_left==0,"Incomplete target stream");copy(recipe,out,suffix);need(fgetc(recipe)==EOF,"Trailing recipe data");
    need(fclose(out)==0,"Closing bundle output failed");fclose(asset);fclose(recipe);source_close(&s);return 0;
}
