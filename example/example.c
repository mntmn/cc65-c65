#include <conio.h>

#define u8 unsigned char
#define u16 unsigned short

u8* screen = (u8*)0x800;

void main() {
  u16 x,y;

  for (y=0; y<25; y++) {
    for (x=0; x<80; x++) {
      screen[x+y*80]=x+y;
    }
  }
}
