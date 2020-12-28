#define u8 unsigned char
#define u16 unsigned short

#define scrw 80
#define scrh 25
#define rectw 20
#define recth 10

u8* screen     = (u8*)0x0800;
u8* m65_ioreg  = (u8*)0xd02f;

void mainloop() {
  u16 x,y,c;
  while (1) {
    for (y=scrh/2-recth/2; y<scrh/2+recth/2; y++) {
      for (x=scrw/2-rectw/2; x<scrw/2+rectw/2; x++) {
        screen[x+y*scrw]=x+y+c;
      }
    }
    c++;
    screen[0] = c;
  }
}

void main() {
  //*m65_ioreg = 0x47;
  //*m65_ioreg = 0x53;
  screen[0] = 0;
  mainloop();
}
