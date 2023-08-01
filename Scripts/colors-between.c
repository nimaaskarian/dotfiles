#include <stdlib.h>
#include <unistd.h>
#include "color.h"

int main(int argc, char *argv[])
{
  Color fromColor = black(), toColor = black();
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
  StdColor stdToColor = colorToStdColor(toColor);
  StdColor stdFromColor = colorToStdColor(fromColor);

  StdColor colorDifference;
  colorDifference.r = (stdToColor.r - stdFromColor.r)/colorsCount;
  colorDifference.g = (stdToColor.g - stdFromColor.g)/colorsCount;
  colorDifference.b = (stdToColor.b - stdFromColor.b)/colorsCount;

  for (int i = 1-iflag; i < colorsCount+iflag; ++i) {
    StdColor currentAddition = multipleStdColor(colorDifference ,i);
    printColor(StdColorToColor(addStdColors(stdFromColor,  currentAddition)));
  }
    
  return EXIT_SUCCESS;
}

void printHelpAndExit(char *argv[])
{
  printf("%s [-i] [-f] fromColor [-t] toColor [-c] stepsCount",argv[0]);
}
