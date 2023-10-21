#include "helpers.h"
#include <math.h>

// Convert image to grayscale
void grayscale(int height, int width, RGBTRIPLE image[height][width])
{
    for (unsigned int i = 0; i < height; i++)
        for (unsigned int j = 0; j < width; j++)
        {
            int avrage = round((image[i][j].rgbtBlue + image[i][j].rgbtGreen + image[i][j].rgbtRed) / 3.0);
            image[i][j].rgbtBlue = avrage;
            image[i][j].rgbtGreen = avrage;
            image[i][j].rgbtRed = avrage;
        }

    return;
}

// Reflect image horizontally
void reflect(int height, int width, RGBTRIPLE image[height][width])
{
    for (unsigned int i = 0; i < height; i++)
        for (unsigned int j = 0; j < width / 2; j++)
        {
            RGBTRIPLE temp = image[i][j];
            image[i][j] = image[i][width - 1 - j];
            image[i][width - 1 - j] = temp;
        }

    return;
}

// Blur image
void blur(int height, int width, RGBTRIPLE image[height][width])
{
    RGBTRIPLE temp[height][width];

    for (int i = 0; i < height; i++)
    {
        for (int j = 0; j < width; j++)
        {
            float sumBlue = 0, sumGreen = 0, sumRed = 0, counter = 0;

            for (int r = -1; r < 2; r++)
                for (int c = -1; c < 2; c++)
                {
                    if (i + r < 0 || i + r > height - 1)
                        continue;

                    if (j + c < 0 || j + c > width - 1)
                        continue;

                    sumBlue += image[i + r][j + c].rgbtBlue;
                    sumGreen += image[i + r][j + c].rgbtGreen;
                    sumRed += image[i + r][j + c].rgbtRed;
                    counter++;
                }

            temp[i][j].rgbtBlue = round(sumBlue / counter);
            temp[i][j].rgbtGreen = round(sumGreen / counter);
            temp[i][j].rgbtRed = round(sumRed / counter);
        }
    }

    for (int i = 0; i < height; i++)
        for (int j = 0; j < width; j++)
        {
            image[i][j].rgbtBlue = temp[i][j].rgbtBlue;
            image[i][j].rgbtGreen = temp[i][j].rgbtGreen;
            image[i][j].rgbtRed = temp[i][j].rgbtRed;
        }

    return;
}

void edges(int height, int width, RGBTRIPLE image[height][width])
{
    int Gx[3][3] = {{-1, 0, 1}, {-2, 0, 2}, {-1, 0, 1}}, Gy[3][3] = {{-1, -2, -1}, {0, 0, 0}, {1, 2, 1}};

    RGBTRIPLE tempImage[height][width];

    for (unsigned int i = 0; i < height; i++)
        for (unsigned int j = 0; j < width; j++)
        {
            int Gx_Blue = 0, Gy_Blue = 0, Gx_Green = 0, Gy_Green = 0, Gx_Red = 0, Gy_Red = 0;

            for (int r = -1; r < 2; r++)
                for (int c = -1; c < 2; c++)
                {
                    if (i + r < 0 || i + r > height - 1)
                        continue;
                    if (j + c < 0 || j + c > width - 1)
                        continue;

                    Gx_Blue += image[i + r][j + c].rgbtBlue * Gx[r + 1][c + 1];
                    Gy_Blue += image[i + r][j + c].rgbtBlue * Gy[r + 1][c + 1];
                    Gx_Green += image[i + r][j + c].rgbtGreen * Gx[r + 1][c + 1];
                    Gy_Green += image[i + r][j + c].rgbtGreen * Gy[r + 1][c + 1];
                    Gx_Red += image[i + r][j + c].rgbtRed * Gx[r + 1][c + 1];
                    Gy_Red += image[i + r][j + c].rgbtRed * Gy[r + 1][c + 1];
                }

            int blue = round(sqrt(Gx_Blue * Gx_Blue + Gy_Blue * Gy_Blue)),
                green = round(sqrt(Gx_Green * Gx_Green + Gy_Green * Gy_Green)),
                red = round(sqrt(Gx_Red * Gx_Red + Gy_Red * Gy_Red));

            if (blue > 255)
                blue = 255;

            if (green > 255)
                green = 255;

            if (red > 255)
                red = 255;

            tempImage[i][j].rgbtBlue = blue;
            tempImage[i][j].rgbtGreen = green;
            tempImage[i][j].rgbtRed = red;
        }

    for (unsigned int i = 0; i < height; i++)
        for (unsigned int j = 0; j < width; j++)
        {
            image[i][j].rgbtBlue = tempImage[i][j].rgbtBlue;
            image[i][j].rgbtGreen = tempImage[i][j].rgbtGreen;
            image[i][j].rgbtRed = tempImage[i][j].rgbtRed;
        }

    return;
}