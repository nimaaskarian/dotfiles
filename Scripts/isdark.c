// vim:fileencoding=utf-8:foldmethod=marker

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <ctype.h>
#include <math.h>

#define R colorInt[0]
#define G colorInt[1]
#define B colorInt[2]

// Declarations {{{
inline double getRgbLuma(int r,int g, int b);
int convertDigitHexToDecimal(char hex, int nthDigit);
int powInt(int base, int power); 
void printUsageAndExit(char *argv[]);
// }}}

int main(int argc, char *argv[])
{
  char colorChars[6] = {0,0,0,0,0,0};
  int colorInt[3] = {0,0,0};
  int opt = 0;

  int cflag = 0, rflag = 0, lflag = 0, printIsDark = 1;
  while ((opt = getopt(argc, argv, "c:r:lL")) != -1) {
    switch (opt) {
      case 'c': {
        if (rflag) printUsageAndExit(argv);
        cflag = 1;

        int colorCount = sscanf(optarg, "#%c%c%c%c%c%c", &colorChars[0], &colorChars[1], &colorChars[2],&colorChars[3], &colorChars[4], &colorChars[5]);
        if (colorCount == 3) {
          // when we have 3 chars, we want to split them so:
          // 0: 0,1
          // 1: 2,3
          // 2, 4,5
          colorChars[4] = colorChars[2];
          colorChars[2] = colorChars[1];

          for (int i = 0; i < 6; i+=2)
            colorChars[i+1] = colorChars[i];
        }
        else if(colorCount != 6)
          printUsageAndExit(argv);
        break;
      }
      case 'l':{
        lflag = 1;
        break;
      }
      case 'L':{
        lflag = 1;
        printIsDark = 0;
        break;
      }
      case 'r': {
        if (cflag) printUsageAndExit(argv);
        rflag = 1;
        if (sscanf(optarg, "%d,%d,%d", &R, &G, &B) != 3)
          printUsageAndExit(argv);
        break;
      }
     case '?':
        printUsageAndExit(argv);
        return 1;
      default:
        abort ();
    }
  }
  if (!cflag && !rflag) {
    printUsageAndExit(argv);
  }
  if (cflag) {
    int j = 0;
    for (int i = 0; i < 6; i++) {
      colorInt[j]+=convertDigitHexToDecimal(colorChars[i],1-i%2);
      if (i%2) 
        j++;
    }
  }
  double luma = getRgbLuma(R,G,B);
  // MIN_luma: 0
  // MAX_luma: 255
  // a color is dark when luma <= %50 * MAX_luma 
  if (printIsDark) {
    int isDark = luma <= 127.5;
    printf("%d\n", isDark);
  }

  if (lflag)
    printf("luma: %f\n", luma);

  return EXIT_SUCCESS;
}

inline double getRgbLuma(int r,int g, int b)
{
  return sqrt(0.299*r*r+0.587*g*g+0.114*b*b);
}

void printUsageAndExit(char *argv[])
{
  fprintf(stderr, "Usage: %s [-c] hexcolor | [-r] r,g,b [-l]\n", argv[0]);
  exit(EXIT_FAILURE);
}

int convertDigitHexToDecimal(char hex, int nthDigit) 
{
  int hexInt = hex - '0';
  if (hexInt > 9) {
    hex = tolower(hex);
    hexInt = hex - 'a' + 10;
  }
  return hexInt*powInt(16,nthDigit);
}

int powInt(int base, int power)
{
  int output = 1;
  while (power--) {
    output*=base;
  }
  return output;
}

