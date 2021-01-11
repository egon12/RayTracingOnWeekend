#ifndef SPHERE_H
#define SPHERE_H

#include <memory>
#include "hitable.h"
#include "vec3.h"

class sphere: public hitable {
	public:
		sphere() {}
		sphere(point cen, double r) : center(cen), radius(r) {}

		virtual bool hit(
				const ray& r,
				double t_min,
				double t_max) const override;


	public:
		point center;
		double radius;
};


/**
 * t**2 * direction . direction + t * 2 * direction . (O - C) + (O - C) . (O - C) - r**2 = 0
 *
 * a = direction . direction
 * b = 2 * direction . (O-C)
 * c = (O - C) . (O - C) - r**2
 *
 * rumus persamaan kuadarat
 * b +/- sqrt(b**2 - 4ac) / 2a
 */

bool sphere::hit(const ray& r, double t_min, double t_max) const {
	vec3 oc = r.origin() - center;
    auto a = dot(r.direction(), r.direction());
    auto b = 2.0 * dot(oc, r.direction());
    auto c = dot(oc, oc) - radius*radius;
    auto discriminant = b*b - 4*a*c;
    return (discriminant > 0);
}

/*
bool sphere::hit(const ray& r, double t_min, double t_max, hit_record& rec) const {

	vec3 oc = r.origin() - center;
	auto a = r.direction().length_squared();
	auto half_b  = dot(oc, r.direction());
	auto c = oc.length_squared() - radius * radius;

	auto discriminant = half_b * half_b - a * c;
	if (discriminant < 0) return false;

	auto sqrtd = sqrt(discriminant);

	auto root = (-half_b - sqrtd) / a;
	if (root < t_min || t_max < root) {
		root = (-half_b + sqrtd) / a;
		if (root < t_min || t_max < root) {
			return false;
		}
	}

	rec.t = root;
	rec.p = r.at(rec.t);
	vec3 outward_normal = (rec.p - center) / radius;
	rec.set_face_normal(r, outward_normal);
	rec.mat_ptr = mat_ptr;

	return true;
}
*/

#endif
