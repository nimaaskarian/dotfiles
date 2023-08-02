#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#ifndef COLOR_H
#define COLOR_H

typedef struct Color {
  int r, g, b; 
} Color;

typedef struct sRGB {
  double r, g, b;
} StdColor;

static inline void threeDigitHexToSix(Color *color);
static inline Color black()
{
  Color output;
  output.r = 0;
  output.g = 0;
  output.b = 0;
  return output;
}

static inline StdColor multipleStdColor(StdColor a, unsigned int m)
{
  a.r *= m;
  a.g *= m;
  a.b *= m;
  return a;
}

static inline StdColor addStdColors(StdColor a,StdColor b) 
{
  StdColor output = a;
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

static inline StdColor colorToStdColor(Color color)
{
  StdColor output;
  output.r = (double)color.r/255;
  output.g = (double)color.g/255;
  output.b = (double)color.b/255;
  return output;
}
static inline Color StdColorToColor(StdColor color)
{
  Color output;
  output.r = (int)(color.r*255);
  output.g = (int)(color.g*255);
  output.b = (int)(color.b*255);
  return output;
}

static inline double contrastRatio(double luma1, double luma2)
{
  if (luma1>luma2)
     return ( luma1 +0.05 )/( luma2 +0.05);
  else
     return ( luma2 +0.05 )/( luma1 +0.05);
}

static inline void fixStdColorParameterForRelativeLuma(double *param)
{
  if (*param <= 0.04045)
    *param = *param/12.92;
  else
    *param = pow(((*param+0.055)/1.055), 2.4);

}
static inline double relativeLuminance(Color color)
{

  StdColor srgb = colorToStdColor(color);

  fixStdColorParameterForRelativeLuma(&srgb.r);
  fixStdColorParameterForRelativeLuma(&srgb.g);
  fixStdColorParameterForRelativeLuma(&srgb.b);

  return 0.2126*srgb.r + 0.7152*srgb.g + 0.0722 * srgb.b;
}

static inline int getColorFromCharPointer(Color *color, char *charPtr)
{
  int colorsFound = sscanf(charPtr, "#%02x%02x%02x", &color->r,&color->g,&color->b);
  if(colorsFound != 3) {
    if (colorsFound == 2 && sscanf(charPtr,"#%01x%01x%01x",&color->r,&color->g, &color->b) == 3) {
      threeDigitHexToSix(color);
    } else
      return EXIT_FAILURE;
  }
  return EXIT_SUCCESS;
}

static inline int getColorFromRgbCharPointer(Color *color, char*charPtr)
{
  if (sscanf(charPtr, "%d,%d,%d", &color->r, &color->g, &color->b) != 3) {
    return EXIT_FAILURE;
  }
  return EXIT_SUCCESS;
}

static inline void printColor (Color color)
{
  printf("#%02x%02x%02x\n", color.r,color.g,color.b);
}

static inline void printStdColor (StdColor srgb)
{
  printColor(StdColorToColor(srgb));
}

static inline void printColorRgb(Color color)
{
  printf("%d,%d,%d\n", color.r,color.g,color.b);
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
  // return 0.2126 * color.r + 0.7152 * color.g + 0.0722 * color.b;
  return sqrt(0.299*color.r*color.r+0.587*color.g*color.g+0.114*color.b*color.b);
}
#endif
