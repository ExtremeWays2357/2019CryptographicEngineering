/* Based on the public domain implemntation in
 * crypto_stream/chacha20/e/ref from http://bench.cr.yp.to/supercop.html
 * by Daniel J. Bernstein */

#include <stdint.h>

#define ROUNDS 20

typedef uint32_t uint32;

static uint32 load_littleendian(const unsigned char *x)
{
  return
      (uint32) (x[0]) \
  | (((uint32) (x[1])) << 8) \
  | (((uint32) (x[2])) << 16) \
  | (((uint32) (x[3])) << 24);
}

static void store_littleendian(unsigned char *x,uint32 u)
{
  x[0] = u; u >>= 8;
  x[1] = u; u >>= 8;
  x[2] = u; u >>= 8;
  x[3] = u;
}

static uint32 rotate(uint32 a, int d)
{
  uint32 t;
  t = a >> (32-d);
  a <<= d;
  return a | t;
}

extern void fullround3(uint32 *a);
static void quarterround(uint32 *a, uint32 *b, uint32 *c, uint32 *d)
{
  /**
   * Deze 12 lines gaan we dus in assembly schrijven en dan niet deze static void gebruiken, maar onze functie
   * + geeft nog steeds een addition aan in c (aldus de ChaCha paper)
   * ^ geeft een XOR aan in c
   * & geeft een AND aan in c 
   * rotate() roteert naar links met het tweede argument
   */
  *a = *a + *b;
  *d = *d ^ *a;
  *d = rotate(*d, 16);

  *c = *c + *d;
  *b = *b ^ *c;
  *b = rotate(*b, 12);

  *a = *a + *b;
  *d = *d ^ *a;
  *d = rotate(*d, 8);

  *c = *c + *d;
  *b = *b ^ *c;
  *b = rotate(*b, 7);
}


static int crypto_core_chacha20(
        unsigned char *out,
  const unsigned char *in,
  const unsigned char *k,
  const unsigned char *c
)
{
 // uint32 x0, x1, x2, x3, x4, x5, x6, x7, x8, x9, x10, x11, x12, x13, x14, x15;
 // uint32 j0, j1, j2, j3, j4, j5, j6, j7, j8, j9, j10, j11, j12, j13, j14, j15;
  int i;
  uint32 x[16];
  uint32 j[16];
  j[0]  = x[0]  = load_littleendian(c +  0);
  j[1]  = x[1]  = load_littleendian(c +  4);
  j[2]  = x[2]  = load_littleendian(c +  8);
  j[3]  = x[3]  = load_littleendian(c + 12);
  j[4]  = x[4]  = load_littleendian(k +  0);
  j[5]  = x[5]  = load_littleendian(k +  4);
  j[6]  = x[6]  = load_littleendian(k +  8);
  j[7]  = x[7]  = load_littleendian(k + 12);
  j[8]  = x[8]  = load_littleendian(k + 16);
  j[9]  = x[9]  = load_littleendian(k + 20);
  j[10] = x[10] = load_littleendian(k + 24);
  j[11] = x[11] = load_littleendian(k + 28);
  j[12] = x[12] = load_littleendian(in+  8);
  j[13] = x[13] = load_littleendian(in+ 12);
  j[14] = x[14] = load_littleendian(in+  0);
  j[15] = x[15] = load_littleendian(in+  4);

  for (i = ROUNDS;i > 0;i -= 2) {
    //send_USART_str((unsigned char*) "\nBefore");
    //send_USART_bytes((unsigned char*) x, 64);
    fullround3(x);
    //quarterround3(x);
//    quarterround(&x[0], &x[4], &x[8],&x[12]);
//    quarterround(&x[1], &x[5], &x[9],&x[13]);
//    quarterround(&x[2], &x[6],&x[10],&x[14]);
//    quarterround(&x[3], &x[7],&x[11],&x[15]);
//    quarterround(&x[3], &x[4], &x[9],&x[14]);//reorder this in assembly to immediately execute after the first full round, so we can keep x14 and x15 in memory
//    quarterround(&x[0], &x[5],&x[10],&x[15]);
//    quarterround(&x[1], &x[6],&x[11],&x[12]);
//    quarterround(&x[2], &x[7], &x[8],&x[13]);
//    send_USART_str((unsigned char*) "\nAfter");
//    send_USART_bytes((unsigned char* )x, 64);
  }

  x[0] += j[0];
  x[1] += j[1];
  x[2] += j[2];
  x[3] += j[3];
  x[4] += j[4];
  x[5] += j[5];
  x[6] += j[6];
  x[7] += j[7];
  x[8] += j[8];
  x[9] += j[9];
  x[10] += j[10];
  x[11] += j[11];
  x[12] += j[12];
  x[13] += j[13];
  x[14] += j[14];
  x[15] += j[15];

  store_littleendian(out + 0,x[0]);
  store_littleendian(out + 4,x[1]);
  store_littleendian(out + 8,x[2]);
  store_littleendian(out + 12,x[3]);
  store_littleendian(out + 16,x[4]);
  store_littleendian(out + 20,x[5]);
  store_littleendian(out + 24,x[6]);
  store_littleendian(out + 28,x[7]);
  store_littleendian(out + 32,x[8]);
  store_littleendian(out + 36,x[9]);
  store_littleendian(out + 40,x[10]);
  store_littleendian(out + 44,x[11]);
  store_littleendian(out + 48,x[12]);
  store_littleendian(out + 52,x[13]);
  store_littleendian(out + 56,x[14]);
  store_littleendian(out + 60,x[15]);

  return 0;
}

static const unsigned char sigma[16] = "expand 32-byte k";

int crypto_stream_chacha20(unsigned char *c,unsigned long long clen, const unsigned char *n, const unsigned char *k)
{
  unsigned char in[16];
  unsigned char block[64];
  unsigned char kcopy[32];
  unsigned long long i;
  unsigned int u;

  if (!clen) return 0;

  for (i = 0;i < 32;++i) kcopy[i] = k[i];
  for (i = 0;i < 8;++i) in[i] = n[i];
  for (i = 8;i < 16;++i) in[i] = 0;

  while (clen >= 64) {
    crypto_core_chacha20(c,in,kcopy,sigma);

    u = 1;
    for (i = 8;i < 16;++i) {
      u += (unsigned int) in[i];
      in[i] = u;
      u >>= 8;
    }

    clen -= 64;
    c += 64;
  }

  if (clen) {
    crypto_core_chacha20(block,in,kcopy,sigma);
    for (i = 0;i < clen;++i) c[i] = block[i];
  }
  return 0;
}
