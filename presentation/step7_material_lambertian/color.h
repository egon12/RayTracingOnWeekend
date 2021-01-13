#ifndef COLOR_H
#define COLOR_H

#include "vec3.h"

#include <iostream>

inline double clamp(double x, double min, double max) {
    if (x < min) return min;
    if (x > max) return max;
    return x;
}

void write_color(std::ostream &out, color pixel_color) {
	auto r = pixel_color.x();
	auto g = pixel_color.y();
	auto b = pixel_color.z();

	r = sqrt(clamp(r, 0.0, 0.999));
	g = sqrt(clamp(g, 0.0, 0.999));
	b = sqrt(clamp(b, 0.0, 0.999));
	//out << "why b" << b << "\n";

    // Write the translated [0,255] value of each color component.
    out << static_cast<int>(256 * r) << ' '
        << static_cast<int>(256 * g) << ' '
        << static_cast<int>(256 * b) << '\n';
}

#endif
