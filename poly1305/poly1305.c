/*
20080912
D. J. Bernstein
Public domain.
*/

#include "poly1305.h"
#include <stdint.h>

static void add(unsigned int h[17],const unsigned int c[17])
{
  unsigned int j;
  unsigned int u;
  u = 0;
  for (j = 0;j < 17;++j) {
      u += h[j] + c[j]; 
      h[j] = u & 255; 
      u >>= 8; 
  }
}

/**
 * een add functie in radix 26. Volgens mij hoeven we niet op de laatste carry te letten omdat c altijd kleiner is
 * dan 2^129, zoals ook in t paper staat. Dan kan de laatste nooit een carry bit genereren. 
 */
static void add26(unsigned int h[5],const unsigned int c[5])
{
  unsigned int j;
  unsigned int u;
  u = 0;
  for (j = 0;j < 5;++j) {
      u += h[j] + c[j]; 
      h[j] = u & 67108863; 
      u >>= 26; 
  }
}

static void squeeze(unsigned int h[17])
{
  unsigned int j;
  unsigned int u;
  u = 0;
  for (j = 0;j < 16;++j) { 
      u += h[j]; 
      h[j] = u & 255; 
      u >>= 8;
  }
  u += h[16]; 
  h[16] = u & 3;
  //Als u een carry had, dan is derde bit van u een 1. Daarom kunnen we rotaten naar rechts met 2 om die carry bit te krijgen, en vermenigvuldigen we met 5 om +5 te doen op de laagste.
  u = 5 * (u >> 2);
 
  for (j = 0;j < 16;++j) { 
      u += h[j]; 
      h[j] = u & 255; 
      u >>= 8;
  }
  u += h[16]; h[16] = u;
}

/**
 * een shell voor een squeeze in radix 26. Dit voegt carries toe bij elkaar oid. Ik denk dat t pas belangrijk is om een werkende sqeeze te hebben wanneer we een werkende mult hebben.


Toevoeging door Marvin - Gelet op lecture van peter:
 p = 2^130-5
 dus
 2^130 == 5 (mod p)
 dus
 2^131 == 10(mod p)
 dus
 for (i=0; i<15; i++)
	r[i] += 10*r[i+16]

	...ik weet nog niet hoe dit vertaalt naar squeeze...
	
 Toevoeging Noël: dit is precies wat "u = 5 * (u >> 26);" doet, volgens mij. 
 2^130 is nml de carry bit, en voor iedere daarbuiten moet je dus 5 toevoegen.
 */
static void squeeze26(unsigned int h[5])
{
  unsigned int j;
  unsigned int u;
  u = 0;
  for (j = 0;j < 4;++j) { 
      u += h[j]; 
      h[j] = u & 67108864; 
      u >>= 26;
  }

  //Deze laatste stap begrijp ik dus echt voor geen bal. Omdat we in radix 26 werken kunnen we de eerste 2 instructies volgens mij gewoon in de loop pleuren, maar die laatste is ??????????
  u += h[4]; 
  //Reduce our result to a number < 2^130-5
  h[4] = u & 67108864;
  u = 5 * (u >> 26);
 
  //The above operations could introduce additional carries, so we fix the carry again.
  for (j = 0;j < 5;++j) { 
      u += h[j]; 
      h[j] = u & 67108864; 
      u >>= 26;
  }
}

static const unsigned int minusp[17] = {
  5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 252
} ;

static void freeze(unsigned int h[17])
{
  unsigned int horig[17];
  unsigned int j;
  unsigned int negative;
  for (j = 0;j < 17;++j) {
      horig[j] = h[j];
  }
  add(h,minusp);
  negative = -(h[16] >> 7);
  for (j = 0;j < 17;++j){
     h[j] ^= negative & (horig[j] ^ h[j]);

  }
}

/*
	Source: http://loup-vaillant.fr/tutorials/poly1305-design
*/
uint64_t propagate_carry(uint64_t p[5], uint64_t carry)
{
    p[0] += carry * 5;  carry = p[0] >> 26;  p[0] -= carry << 26;
    p[1] += carry    ;  carry = p[1] >> 26;  p[1] -= carry << 26;
    p[2] += carry    ;  carry = p[2] >> 26;  p[2] -= carry << 26;
    p[3] += carry    ;  carry = p[3] >> 26;  p[3] -= carry << 26;
    p[4] += carry    ;  carry = p[4] >> 26;  p[4] -= carry << 26;
    return carry;
}

/*
	Source: http://loup-vaillant.fr/tutorials/poly1305-design
*/
static void mulmod26(uint64_t p[5], const uint32_t a[5], const uint32_t b[5])
{
	uint64_t a0 = a[0];  uint64_t b0 = b[0];
	uint64_t a1 = a[1];  uint64_t b1 = b[1];  uint64_t b51 = b[1] * 5;
	uint64_t a2 = a[2];  uint64_t b2 = b[2];  uint64_t b52 = b[2] * 5;
	uint64_t a3 = a[3];  uint64_t b3 = b[3];  uint64_t b53 = b[3] * 5;
	uint64_t a4 = a[4];  uint64_t b4 = b[4];  uint64_t b54 = b[4] * 5;
	p[0] = a0*b0 + a1*b54 + a2*b53 + a3*b52 + a4*b51;
	p[1] = a0*b1 + a1*b0  + a2*b54 + a3*b53 + a4*b52;
	p[2] = a0*b2 + a1*b1  + a2*b0  + a3*b54 + a4*b53;
	p[3] = a0*b3 + a1*b2  + a2*b1  + a3*b0  + a4*b54;
	p[4] = a0*b4 + a1*b3  + a2*b2  + a3*b1  + a4*b0 ;

	/* This loop is prone to timing attacks, according to source. May need to unroll */
	uint64_t carry = 0;
	do {
    		carry = propagate_carry(p, carry);
	} while (carry != 0);
/*
   Modified code from the lecture for carries after multiplication (original code was radix 16. Did I rewrite it
	correctly for radix 26, or do I need to also change the length of the loop?)
	
   Comments Noël (zonder dingen aan te passen, voor nu):
   	- Onze loop loopt niet over 15 elementen, want we hebben 5 26-bits getallen.
	- Dit is enkel het toevoegen van carries, niet de multiplication zelf (toch?)
   In feite gaan we denk ik nóg een squeeze maken, die unsigned long longs reduceert naar unsigned ints.
   
   long long c
   for(i=0;i<15;i++)
   {
      // shift by 26, because our radix is 26. It used to be 16, according to Peter, because radix was 16
      c = r[i] >> 26;
      r[i+1] += c;
      c <<= 26;
      r[i] -= c;
   }
   c = r[15] >> 26;
   # reduce by 10, because 
   r[0] += 10*c;
   c <<= 26;
   r[15] -= c
*/
}


/**
 * Dit kunnen we niet simpel omschrijven, we moeten gewoon eigen multiplication arithmic gaan schrijven voor 2^26 multiplicatie :(
 */
static void mulmod(unsigned int h[17],const unsigned int r[17])
{
  unsigned int hr[17];
  unsigned int i;
  unsigned int j;
  unsigned int u;

  for (i = 0;i < 17;++i) {
    u = 0;
    for (j = 0;j <= i;++j){
       u += h[j] * r[i - j];
    }
    for (j = i + 1;j < 17;++j){
       u += 320 * h[j] * r[i + 17 - j];
    }
    hr[i] = u;
  }
  for (i = 0;i < 17;++i) {
      h[i] = hr[i];
  }
  squeeze(h);
}

// Putting these here for inspiratio, nothing else.
/* Adapted from https://github.com/floodyberry/poly1305-donna/blob/master/poly1305-donna-32.h. */
/* interpret four 8 bit unsigned integers as a 26 bit unsigned integer in little endian */
static unsigned int
U8TO26(const unsigned int *p, unsigned char offset, unsigned char AND) {
	return
	(((unsigned int)((p[0] >> offset)  & 0xff))		+
	((unsigned int)(p[1] & 0xff) <<  (8-offset))		+
	((unsigned int)(p[2] & 0xff) << (16-offset))		+
	((unsigned int)(p[3] & AND) << (24-offset))); 
}

/* From https://github.com/floodyberry/poly1305-donna/blob/master/poly1305-donna-32.h. */
/* This function is not adapted, it wouldn't work if used like this. 
v should probably be unsigned int, and so should p. Then we fill p[0]-p[3] with bytes. However, there is still the offsett to deal with
(in Noëls function, we hardcode the offset. They would be functionally equivalent). */
static void
U26TO8(unsigned char *p, unsigned long v) {
	p[0] = (v      ) & 0xff;
	p[1] = (v >>  8) & 0xff;
	p[2] = (v >> 16) & 0xff;
	p[3] = (v >> 24) & 0x3;
}


//een van de conversies faalt. Mogelijk allebei
// >> = shift naar rechts.
// << = shift naar links.
static void convert_to_radix26(unsigned int source[17], unsigned int dest[5]){
	// My original idea inspired by the github 32-bit implementation was something like:
	/*
		dest[0] = U8TO26(&source[0])
		dest[1] = U8TO26(&source[3]+offset)
		dest[2] = U8TO26(&source[6]+offset)
		dest[3] = U8TO26(&source[9]+offset)
		dest[4] = U8TO26(&source[13])
		But this obviously wouldnt work, as we cannot put the offset right...(we cannot do &source[3]+0.25).
	*/
	dest[0] = U8TO26( &source[0],0, 3);
	dest[1] = U8TO26( &source[3],2, 15);
	dest[2] = U8TO26( &source[6],4, 63);
	dest[3] = U8TO26( &source[9],6, 255);
	dest[4] = U8TO26( &source[13],0,3);

	/*
	dest[0]  = (source[0]);
	dest[0] += (source[1] << 8);
	dest[0] += (source[2] << 16);
	dest[0] += (source[3] & 3) << 24; //Only care about 2 least significant bits

	dest[1]  = (source[3] >> 2);
	dest[1] += (source[4] << 6);
	dest[1] += (source[5] << 14);
	dest[1] += (source[6] & 15) << 22;//Only care about 4 least significant bits

	dest[2]  = (source[6] >> 4);
	dest[2] += (source[7] << 4);
	dest[2] += (source[8] << 12);
	dest[2] += (source[9] & 63) << 20;//Only care about 6 least significant bits
	
	dest[3]  = (source[9] >> 6);
	dest[3] += (source[10] << 2);
	dest[3] += (source[11] << 10);
	dest[3] += (source[12] << 18); 

	dest[4]  = (source[13]);
	dest[4] += (source[14] << 8);
	dest[4] += (source[15] << 16);
	dest[4] += (source[16] & 3) << 24 ;//only care about 2 least significant bits
	*/
}

//volgens mij is dit 100% ruk, van rotatierichting tot de AND-values. Volgens mij moet alles de andere kant op.
static void convert_to_bytearray(unsigned int source[5], unsigned int dest[17]){
	dest[0] =  (source[0]) & 255;
	dest[1] =  (source[0] >> 8 ) & 255;
	dest[2] =  (source[0] >> 16) & 255;
	dest[3] =  (source[0] >> 24) & 3;//only care about 2 least significant bits
	dest[3] += (source[1] << 2 ) & 252;//only care about 6 least signifcant bits, but place them in upper part
	dest[4] =  (source[1] >> 6 ) & 255;
	dest[5] =  (source[1] >> 14) & 255;
	dest[6] =  (source[1] >> 22) & 15;//only care about 4 least significant bits
	dest[6] += (source[2] << 4 ) & 240; //only care about 4 least signifant bits, but place them in upper part
	dest[7] =  (source[2] >> 4 ) & 255;
	dest[8] =  (source[2] >> 12) & 255;
	dest[9] =  (source[2] >> 20) & 63;//only care about 6 bits
	dest[9] += (source[3] << 6 ) & 192;//only care about 2 bits
	dest[10]=  (source[3] >> 2 ) & 255;
	dest[11]=  (source[3] >> 10) & 255;
	dest[12]=  (source[3] >> 18) & 255;
	dest[13]=  (source[4]) & 255;
	dest[14]=  (source[4] >> 8 ) & 255;
	dest[15]=  (source[4] >> 16) & 255;
	dest[16]=  (source[4] >> 24) & 3; //only 2 lsb
}

int crypto_onetimeauth_poly1305(unsigned char *out,const unsigned char *in,unsigned long long inlen,const unsigned char *k)
{
  unsigned int j;
  unsigned int r[17];
  unsigned int h[17];
  unsigned int tmp[5];
  unsigned int tmp2[5];
  unsigned int c[17];
  r[0] = k[0];
  r[1] = k[1];
  r[2] = k[2];
  r[3] = k[3] & 15;
  r[4] = k[4] & 252;
  r[5] = k[5];
  r[6] = k[6];
  r[7] = k[7] & 15;
  r[8] = k[8] & 252;
  r[9] = k[9];
  r[10] = k[10];
  r[11] = k[11] & 15;
  r[12] = k[12] & 252;
  r[13] = k[13];
  r[14] = k[14];
  r[15] = k[15] & 15;
  r[16] = 0;
  //Convert r to radix 2^26

  for (j = 0;j < 17;++j) {
      h[j] = 0;//Convert h to radix 2^26
  }
  //convert_to_radix26(h, tmp);
  //convert_to_bytearray(tmp, h);

  /**
   * for (j = 0; j < 5; j++){
   *	h[j] = 0;
   * }
   */

  while (inlen > 0) {
    for (j = 0;j < 17;++j) {
	c[j] = 0;
    }
    for (j = 0;(j < 16) && (j < inlen);++j) {
	c[j] = in[j];
	//Merk op dat j[16] altijd <= 1 is. Dat betekent dat is kleiner is dan 2^129
    }
    c[j] = 1;

    /**
     * Convert c to radix 2^26 in a new variable
     * */
    in += j; inlen -= j;
    
	//convert_to_radix26(h, tmp);
	//convert_to_radix26(c, tmp2);
	//convert_to_bytearray(tmp, h);
	//add26(tmp,tmp2);
	//convert_to_bytearray(tmp, h);
	//convert_to_bytearray(tmp2,c);
	add(h,c);
	mulmod(h,r);
  }

  freeze(h);

  for (j = 0;j < 16;++j){ 
      c[j] = k[j + 16];
  }
  c[16] = 0;
  //convert c to radix 2^26 once more
  add(h,c);
  //convert h back to bytearray
  for (j = 0;j < 16;++j){
      out[j] = h[j];
  }
  return 0;
}
