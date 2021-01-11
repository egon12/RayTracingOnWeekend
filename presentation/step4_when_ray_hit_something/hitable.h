#ifndef HITABLE_H
#define HITABLE_H

#include "ray.h"

class hitable {
	public:
		virtual bool hit(const ray& r, double t_min, double t_max) const = 0;
};

#endif
