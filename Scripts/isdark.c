#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <ctype.h>

#define COLOR_START_INDEX 1
int convertDigitHexToDecimal(char hex, int nthDigit);
int powInt(int base, int power); 
void printUsageAndExit(char *argv[]);

int main(int argc, char *argv[])
{
  char color[6] = {0,0,0,0,0,0};
  int colorInt[3] = {0,0,0};
  int opt = 0;

  int cflag = 0, rflag = 0;
  while ((opt = getopt(argc, argv, "c:r:")) != -1) {

    switch (opt) {
      case 'c': {
        if (cflag) printUsageAndExit(argv);
        cflag = 1;
        for (int i = COLOR_START_INDEX; i < COLOR_START_INDEX+6; i++)
          color[i] = optarg[i];
        break;
      }
      case 'r': {
        if (cflag) printUsageAndExit(argv);
        rflag = 1;
        if (sscanf(optarg, "%d,%d,%d", &colorInt[0], &colorInt[1], &colorInt[2]) != 3)
          printUsageAndExit(argv);
        break;
      }
      default: /* '?' */
        printUsageAndExit(argv);
    }
  }
  if (!cflag && !rflag) {
    printUsageAndExit(argv);
  }
  int j = 0;
  if (cflag) {
    for (int i = COLOR_START_INDEX; i < COLOR_START_INDEX+6; i++) {
      colorInt[j]+=convertDigitHexToDecimal(color[i],1-(i-COLOR_START_INDEX)%2);
      if ((i-COLOR_START_INDEX)%2) 
        j++;
    }
  }
  // printf("(%d) (%d) (%d)\n", colorInt[0],colorInt[1],colorInt[2]);
  double luma = (double)(color[0]*2+colorInt[1]*3+colorInt[2])/6;
  int isDark = luma <= 85;
  printf("%d\n", isDark);
  return EXIT_SUCCESS;
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

void printUsageAndExit(char *argv[])
{
  fprintf(stderr, "Usage: %s [-c] hexcolor | [-r] r,g,b\n",
    argv[0]);
  exit(EXIT_FAILURE);
}
