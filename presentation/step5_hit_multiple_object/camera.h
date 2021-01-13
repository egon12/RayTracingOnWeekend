#ifndef CAMERA_H
#define CAMERA_H

#include "vec3.h"
#include "ray.h"

class cam {
	public:
		cam() {
			origin = point3(0,0,0);
			left_bottom = point3(-200, -100, 1);

		}

		ray get_ray(double x_pix, double y_pix) const {
			auto dest = left_bottom + vec3(x_pix, y_pix, 1);
			vec3 direction = unit_vector(dest - origin);
			return ray(origin, dest);
		}

	public:
		point3 origin;
		point3 left_bottom;
};

#endif
