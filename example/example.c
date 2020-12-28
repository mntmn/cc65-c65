#define u8 unsigned char
#define u16 unsigned short

#define scrw 80
#define scrh 25
#define rectw 76
#define recth 4

u16 fastcall sin_A(u8 a);
u16 fastcall cos_A(u8 a);

u8* screen        = (u8*)0x0800;
u8* border_color  = (u8*)0xd020;
u8* bg_color      = (u8*)0xd021;
u8* m65_ioreg     = (u8*)0xd02f;

u8* sprites_pos    = (u8*)0xd000;
u8* sprites_data   = (u8*)0x0600;
u8* sprites_active = (u8*)0xd015;
u8* sprites_dblx   = (u8*)0xd01d;
u8* sprites_dbly   = (u8*)0xd017;
u8* sprites_xhi    = (u8*)0xd010;
u8* sprites_color  = (u8*)0xd027;
u8* sprites_depth  = (u8*)0xd01b;

void clear() {
  u16 i;
  for (i=0; i<scrh*scrw; i++) {
    screen[i] = 32;
  }
}

void mainloop() {
  u8 x,y,c,d;

  *bg_color = 0;
  *border_color = 0;

  *sprites_active = 0x3;
  *sprites_dblx   = 0xff;
  *sprites_dbly   = 0xff;
  *sprites_depth  = 0x2;

  while (1) {
    for (y=scrh/2-recth/2; y<scrh/2+recth/2; y++) {
      u16 oy = y*scrw;
      for (x=scrw/2-rectw/2; x<scrw/2+rectw/2; x++) {
        screen[oy+x]=x+y+c;
      }
      //sprites_data[c]=y+c;
    }
    c++;
    d=(c>>2)%16;

    sprites_pos[0] = c;
    sprites_pos[1] = sin_A(c)>>8;
    sprites_pos[2] = 255-c;
    sprites_pos[3] = sin_A(c)>>7;

    sprites_color[0] = d;
    sprites_color[1] = 16-d;
  }
}

void main() {
  clear();
  mainloop();
}
