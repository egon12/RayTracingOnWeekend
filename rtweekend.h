#ifndef RTWEEKEND_H
#define RTWEEKEND_H

#include <cstdlib>
#include <cmath>
#include <memory>
#include <limits>
#include <random>

// Usings

using std::shared_ptr;
using std::make_shared;
using std::sqrt;


// Constant
const double infinity = std::numeric_limits<double>::infinity();
const double pi = 3.1415926535897932385;

// Utility Functions
inline double degrees_to_radians(double degrees) {
	return degrees * pi / 180.0;
}

/*
inline double random_double() {
	// Returns a ranom real in [0, 1]
	return rand() / (RAND_MAX + 1.0);
}
*/

inline double random_double() {
	// Returns a ranom real in [0, 1]
	static std::uniform_real_distribution<double> distribution(0.0, 1.0);
	static std::mt19937 generator;
	return distribution(generator);
}


inline double random_double(double min, double max) {
	// Returns a ranom real in [min, max]
	return min + (max-min) * random_double();
}

inline double clamp(double x, double min, double max) {
	if (x < min) return min;
	if (x > max) return max;
	return x;
}

// comon Headers;
#include "ray.h"
#include "vec3.h"

#endif
