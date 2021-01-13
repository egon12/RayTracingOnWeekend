#ifndef CAMERA_H
#define CAMERA_H

#include "vec3.h"
#include "ray.h"

class cam {
	public:
		cam() {
			origin = point3(0,0,0);
			left_bottom = point3(-2, -1, 1);

			vertical = vec3(0, 2, 0);
			horizontal = vec3(4, 0, 0);
		}

		ray get_ray(double u, double v) const {
			auto dest = left_bottom + u * horizontal + v * vertical;
			return ray(origin, dest);
		}

	public:
		point3 origin;
		point3 left_bottom;
		vec3 vertical;
		vec3 horizontal;
};

#endif
