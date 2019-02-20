#ifndef CHACHA20_H
#define CHACHA20_H

#define CHACHA20_KEYBYTES 32
#define CHACHA20_NONCEBYTES 8



int crypto_stream_chacha20(unsigned char *c,unsigned long long clen, const unsigned char *n, const unsigned char *k);
extern void quarterround2(uint32_t *a, uint32_t *b, uint32_t *c, uint32_t *d);


#endif
