#include <stdlib.h>
#include <unistd.h>
#include "color.h"

void printHelpAndExit(char *argv[]);

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
        if (getColorFromCharPointer(&toColor, optarg) == EXIT_FAILURE)
          printHelpAndExit(argv);

        break;
      case 'f':
        if (getColorFromCharPointer(&fromColor, optarg) == EXIT_FAILURE)
          printHelpAndExit(argv);

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
    printStdColor(addStdColors(stdFromColor,  currentAddition));
  }
    
  return EXIT_SUCCESS;
}

void printHelpAndExit(char *argv[])
{
  printf("%s [-i] [-f] fromColor [-t] toColor [-c] stepsCount\n",argv[0]);
  exit(EXIT_FAILURE);
}
