#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#ifndef COLOR_H
#define COLOR_H

typedef struct Color {
  int r, g, b; 
} Color;

typedef struct DoubleColor {
  double r, g, b;
} DoubleColor;

static inline void threeDigitHexToSix(Color *color);
static inline Color black()
{
  Color output;
  output.r = 0;
  output.g = 0;
  output.b = 0;
  return output;
}

static inline DoubleColor multipleDoubleColor(DoubleColor a, unsigned int m)
{
  a.r *= m;
  a.g *= m;
  a.b *= m;
  return a;
}

static inline Color addDoubleColorToColor(Color a,DoubleColor b)
{
  Color output = a;
  output.r += b.r;
  output.g += b.g;
  output.b += b.b;

  return output;
}

static inline Color addColors(Color a,Color b)
{
  Color output = a;
  output.r += b.r;
  output.g += b.g;
  output.b += b.b;

  return output;
}

static inline int getColorFromOptarg(Color *color)
{
  if((sscanf(optarg, "#%02x%02x%02x", &color->r,&color->g,&color->b)) != 3) {
    if (sscanf(optarg,"#%01x%01x%01x",&color->r,&color->g, &color->b) == 3) {
      threeDigitHexToSix(color);
    } else
      return EXIT_FAILURE;
  }
  return EXIT_SUCCESS;
}

static inline void printColor(Color color)
{
  printf("#%02x%02x%02x\n", color.r,color.g,color.b);
}

static inline void printDoubleColor(DoubleColor color)
{
  printf("%f, %f, %f\n", color.r,color.g,color.b);
}

static inline void threeDigitHexToSix(Color *color) 
{
  // if its a three digit hex color like #ABC, we want to have
  // #AABBCC so we do this:

  color->r += color->r*16;
  color->g += color->g*16;
  color->b += color->b*16;
}

static inline double getColorLuma(Color color)
{
  return sqrt(0.299*color.r*color.r+0.587*color.g*color.g+0.114*color.b*color.b);
}
#endif
