#include "color.h"

int main(int argc, char *argv[])
{
  if (argc < 3)
    exit(EXIT_FAILURE);

  Color c1, c2;
  int opt = 0;
  while ((opt = getopt(argc, argv, "1:2:")) != -1) {
    switch (opt) {
      case '1':
        if (getColorFromCharPointer(&c1, optarg) == EXIT_FAILURE)
          getColorFromRgbCharPointer(&c1,optarg);
        break;
      case '2':
        if (getColorFromCharPointer(&c2, optarg) == EXIT_FAILURE)
          getColorFromRgbCharPointer(&c2,optarg);
        break;
    }
  }

  double l1 = relativeLuminance(c1);
  double l2 = relativeLuminance(c2);
  printf("%f", contrastRatio(l1,l2));

  return EXIT_SUCCESS;
}
