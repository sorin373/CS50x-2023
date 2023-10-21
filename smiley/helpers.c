#include "helpers.h"

void colorize(int height, int width, RGBTRIPLE image[height][width])
{
    // Change all black pixels to a color of your choosing

    for (unsigned int i = 0; i < height; i++)
        for (unsigned int j = 0; j < width; j++)
            if (image[i][j].rgbtRed == 0x00 && image[i][j].rgbtGreen == 0x00 && image[i][j].rgbtBlue == 0x00)
            {
                image[i][j].rgbtRed = 0xE2;
                image[i][j].rgbtGreen = 0xAA;
                image[i][j].rgbtBlue = 0x11;
            }
}
