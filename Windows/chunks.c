/* Build-time content-defined boundaries. No game/runtime dependency. */
#include <stdint.h>
#include <stdio.h>
int main(int argc, char **argv) {
    if (argc != 2) return 2;
    FILE *f = fopen(argv[1], "rb");
    if (!f) return 3;
    uint64_t gear[256], x = 0x4f726573744c6f76ULL;
    for (int i = 0; i < 256; ++i) {
        x ^= x >> 12; x ^= x << 25; x ^= x >> 27;
        gear[i] = x * 2685821657736338717ULL;
    }
    uint64_t pos = 0, start = 0, h = 0;
    unsigned char buf[65536]; size_t n;
    while ((n = fread(buf, 1, sizeof buf, f))) {
        for (size_t i = 0; i < n; ++i) {
            h = (h << 1) + gear[buf[i]]; ++pos;
            if (pos - start >= 8192 && (!(h & 32767) || pos - start >= 65536)) {
                printf("%llu %llu\n", (unsigned long long)start, (unsigned long long)(pos-start));
                start = pos; h = 0;
            }
        }
    }
    if (ferror(f)) { fclose(f); return 4; }
    if (pos != start) printf("%llu %llu\n", (unsigned long long)start, (unsigned long long)(pos-start));
    fclose(f); return 0;
}
