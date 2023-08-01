#include <stdlib.h>
#include <unistd.h>
#include "color.h"

int main(int argc, char *argv[])
{
  Color fromColor, toColor;
  unsigned int colorsCount = 8;

  int opt = 0;
  int iflag = 0;
  while ((opt = getopt(argc, argv, "f:t:c:i")) != -1) {
    switch (opt) {
      case 'i':
        iflag = 1;
        break;
      case 'c':
        colorsCount = atoi(optarg);
        break;
      case 't':
        getColorFromCharPointer(&toColor, optarg);
        break;
      case 'f':
        getColorFromCharPointer(&fromColor, optarg);
        break;
    }
  }
  // because we need one more step than specified number!
  colorsCount++;

  DoubleColor colorDifference;
  colorDifference.r = (double)( toColor.r - fromColor.r )/colorsCount;
  colorDifference.g = (double)( toColor.g - fromColor.g )/colorsCount;
  colorDifference.b = (double)( toColor.b - fromColor.b )/colorsCount;

  for (int i = 1-iflag; i < colorsCount+iflag; ++i) {
    printColor(addDoubleColorToColor(fromColor, multipleDoubleColor(colorDifference ,i) ));
  }
    
  return EXIT_SUCCESS;
}

void printHelpAndExit(char *argv[])
{
  printf("%s [-i] [-f] fromColor [-t] toColor [-c] stepsCount",argv[0]);
}
