#include <iostream>
#include <unistd.h>

#include "vec3.h"

int main() {

	point3 p1;
	vec3 v1(1, .5, 0);

	std::cout << p1 << "\n";

	p1 += v1;
	std::cout << p1 << "\n";

	p1 += v1;
	std::cout << p1 << "\n";

	p1 += v1;
	std::cout << p1 << "\n";

	p1 += v1;
	std::cout << p1 << "\n";

	p1 *= 300;
	std::cout << p1 << "\n";
	/**
	 *
	 */
	auto s =  (p1 + p1 + p1 + p1 + p1) / (p1 * 5);
	std::cout << s << "\n";
	// s = divide(p1.add(p1.add(p1.add(p1.add(p1)))), p1.times(5))
}
