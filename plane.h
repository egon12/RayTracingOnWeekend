#ifndef PLANE_H
#define PLANE_H

#include "hittable.h"
#include "vec3.h"

class plane: public hittable {
	public:
		plane() {}
		// s can be x, y, or z
		plane(char s, double p) : side(s), point(p) {}

		virtual bool hit(
				const ray& r,
				double t_min,
				double t_max,
				hit_record& rec) const override;


	public:
		char side;
		double point;
};

bool plane::hit(const ray& r, double t_min, double t_max, hit_record& rec) const {

	if (side == 'x') {
		rec.t = point - r.origin().y() / r.direction().y();
	}

	if (rec.t < 0) return false;

	rec.p = r.at(rec.t);
	rec.normal = vec3(0, 1, 0);

	return true;
}

#endif
