// vim:fileencoding=utf-8:foldmethod=marker
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <ctype.h>
#include "color.h"

void printUsageAndExit(char *argv[]);

int main(int argc, char *argv[])
{
  Color color;
  int opt = 0;

  int cflag = 0, rflag = 0, lflag = 0, printIsDark = 1;
  while ((opt = getopt(argc, argv, "c:r:lL")) != -1) {
    switch (opt) {
      case 'c': {
        if (rflag) printUsageAndExit(argv);
        cflag = 1;
        if (getColorFromCharPointer(&color, optarg) == EXIT_FAILURE)
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
        if (getColorFromRgbCharPointer(&color,optarg))
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
  double luma = getColorLuma(color);
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

void printUsageAndExit(char *argv[])
{
  fprintf(stderr, "Usage: %s [-c] hexcolor | [-r] r,g,b [-l]\n", argv[0]);
  exit(EXIT_FAILURE);
}

