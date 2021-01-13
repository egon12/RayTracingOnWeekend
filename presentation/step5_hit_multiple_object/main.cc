#include <iostream>
#include <unistd.h>

#include "hittable_list.h"
#include "sphere.h"
#include "camera.h"
#include "color.h"

using std::shared_ptr;
using std::make_shared;
using std::sqrt;


color ray_color(const ray& r, const hittable& world, int depth) {
	hit_record rec;

	// If we've exceeded the ray bounce limit, no more light is gathered
	if (depth <= 0) {
	  return color(.0, .0, .0);
	}

	if (world.hit(r, 0.1, 100000, rec)) {
		point3 target = rec.p + rec.normal + random_in_unit_sphere();
		ray new_ray = ray(rec.p, target - rec.p);
		return 0.5 * ray_color(new_ray, world, depth -1);
	}

	vec3 dir = r.direction();
	dir[0] = 0;
		
	vec3 unit_direction = unit_vector(dir);
	auto t = 0.25*(unit_direction.y() + 1.0);
	return (1.0-t) * color(1.0, 1.0, 1.0) + t * color(0.5, 0.7, 1.0);
}


int main() {

	cam c;
	int image_height = 200;
	int image_width = 400;

	// Object
	hittable_list world;

	world.add(make_shared<sphere>(point3(0,-5,7), 10));
	world.add(make_shared<sphere>(point3(0,0,7), 10));

	// Render

	std::cout << "P3\n" << image_width << " " << image_height << "\n255\n";

	for (int y = image_height-1; y >= 0; --y) {
		std::cerr << "\rScanlines remaining: " << y << ' ' << std::flush;
		for (int x = 0; x < image_width; ++x) {


			ray r = c.get_ray(x, y);
			color pixel_color(0,0,0);

			for (int n=0; n<10; n++) {
				pixel_color += ray_color(r, world, 20);
			}

			pixel_color /= 10;

			write_color(std::cout, pixel_color);

		}
	}

	std::cerr << "\nDone.\n";
}

