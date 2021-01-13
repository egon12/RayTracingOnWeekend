#include <iostream>
#include <unistd.h>

#include "hittable_list.h"
#include "sphere.h"
#include "camera.h"
#include "color.h"
#include "material.h"

using std::shared_ptr;
using std::make_shared;
using std::sqrt;


color ray_color(const ray& r, const hittable& world, int depth) {
	hit_record rec;

	// If we've exceeded the ray bounce limit, no more light is gathered
	if (depth <= 0) {
		return color(0,0,0);
	}

	if (world.hit(r, 0.01, 1000000, rec)) {
		ray scattered;
		color attenuation;

		if (rec.mat_ptr->scatter(r, rec, attenuation, scattered)) {
			return attenuation * ray_color(scattered, world, depth -1);
		}	
		return color(0,0,0);
	}

		
	vec3 unit_direction = unit_vector(r.direction());
	auto t = 0.5*(unit_direction.y() + 1.0);
	return (1.0-t) * color(1.0, 1.0, 1.0) + t * color(0.5, 0.7, 1.0);
}


int main() {

	cam c;
	int image_height = 200;
	int image_width = 400;
	int samples_per_pixels = 10;
	int max_bouncing = 20;

	// Object
	hittable_list world;

	auto ground_material = make_shared<lambertian>(color(0.5, 0.5, 0.5));
	
	auto mat = make_shared<dielectric>(1.5);
	auto redMat = make_shared<blackhole>();

	world.add(make_shared<sphere>(point3(0,-1000.5,1), 1000, ground_material));

	world.add(make_shared<sphere>(point3(0,0,1), 0.5, mat));
	//world.add(make_shared<sphere>(point3(0,0,3), 0.5, mat));

	world.add(make_shared<sphere>(point3(2.2,-.1,4), 0.4, redMat));
	world.add(make_shared<sphere>(point3(0.8,-.1,4), 0.4, redMat));

	// Render

	std::cout << "P3\n" << image_width << " " << image_height << "\n255\n";

	for (int y = image_height-1; y >= 0; --y) {
		std::cerr << "\rScanlines remaining: " << y << ' ' << std::flush;

		for (int x = 0; x < image_width; ++x) {

			color pixel_color(0,0,0);
			for (int i=0; i<samples_per_pixels; i++) {
				double u = (double(x) + random_double()) / (image_width -1);
				double v = (double(y) + random_double()) / (image_height -1);
				ray r = c.get_ray(u, v);
				pixel_color += ray_color(r, world, max_bouncing);
			}
			pixel_color /= samples_per_pixels;

			write_color(std::cout, pixel_color);

		}
	}

	std::cerr << "\nDone.\n";
}

