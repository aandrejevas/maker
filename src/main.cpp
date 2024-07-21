#include <boost/iostreams/device/mapped_file.hpp>
#include <cstdlib>
#include <cstdint>
#include "hh.hpp"

// It is just more efficient to have such a program.
// And it would be really difficult to do the same actions with existing commands.
std::int32_t main(const std::int32_t argc, const char *const *const argv) {
	if (argc != 2) return EXIT_FAILURE;

	const boost::iostreams::mapped_file file = boost::iostreams::mapped_file{argv[1]};
	if (!file.is_open()) return EXIT_FAILURE;

	return EXIT_SUCCESS;
}
