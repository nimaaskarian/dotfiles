#include <stdlib.h>
#include <unistd.h>
#include "color.h"

int main(int argc, char *argv[])
{
  Color fromColor, toColor;
  unsigned int colorsCount = 8;

  int opt = 0;
  while ((opt = getopt(argc, argv, "f:t:c:")) != -1) {
    switch (opt) {
      case 'c':
        colorsCount = atoi(optarg);
        break;
      case 't':
        getColorFromOptarg(&toColor);
        break;
      case 'f':
        getColorFromOptarg(&fromColor);
        break;
    }
  }
  // because we need one more step than specified number!
  colorsCount++;

  DoubleColor colorDifference;
  colorDifference.r = (double)( toColor.r - fromColor.r )/colorsCount;
  colorDifference.g = (double)( toColor.g - fromColor.g )/colorsCount;
  colorDifference.b = (double)( toColor.b - fromColor.b )/colorsCount;

  for (int i = 1; i < colorsCount; ++i) {
    printColor(addDoubleColorToColor(fromColor, multipleDoubleColor(colorDifference ,i) ));
  }
    
  return EXIT_SUCCESS;
}
