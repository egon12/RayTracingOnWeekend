#include<iostream>

void printHeaderFile(int image_width, int image_height);

int main() {

	int w = 400;
	int h = 200;
	printHeaderFile(w, h);

	for (int y=h-1; y>=0; y--) {
		std::cerr << "\rScanlines remaining: " << y << ' ' << std::flush;
		for (int x=0; x<w; x++) {
			unsigned char r = x % 256;
			unsigned char g = 255;
			unsigned char b = 255;

			std::cout << int(r) << ' ' << int(g) << ' ' << int(b) << "\n";
		}
	}

}

void printHeaderFile(int image_width, int image_height) {
	std::cout << "P3\n" << image_width << " " << image_height << "\n255\n";
}


