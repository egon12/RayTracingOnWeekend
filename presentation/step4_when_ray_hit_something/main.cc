#include "camera.h"
#include "sphere.h"

void printHeaderFile(int image_width, int image_height);

int main() {

	cam c;
	sphere s(point(0,0,10.005), 10);

	printHeaderFile(400, 200);
	for (int y=199; y>=0; y--) {
		std::cerr << "\rScanlines remaining: " << y << ' ' << std::flush;

		for (int x=0; x<400; x++) {

			ray r = c.get_ray(double(x), double(y));

			if (s.hit(r, 0.1, 100000)) {
				auto col = color(1.0, .0, .0);
				std::cout << int(col.x() * 255) << ' ' << int(col.y() * 255) << ' ' << int(col.z() * 255) << "\n";
				continue;

			}

			vec3 unit_direction = unit_vector(r.direction());
			auto t = 0.5*(unit_direction.y() + 1.0);
			auto col = (1.0-t) * color(1.0, 1.0, 1.0) + t * color(0.5, 0.7, 1.0);

			std::cout << int(col.x() * 255) << ' ' << int(col.y() * 255) << ' ' << int(col.z() * 255) << "\n";

		}
	}
}

void printHeaderFile(int image_width, int image_height) {
	std::cout << "P3\n" << image_width << " " << image_height << "\n255\n";
}
