#include <boost/iostreams/device/mapped_file.hpp>
#include <cstdlib>

int main(const int argc, const char *const *const argv) {
	if (argc != 2) return EXIT_FAILURE;

	const boost::iostreams::mapped_file file = boost::iostreams::mapped_file{argv[1]};
	if (!file.is_open()) return EXIT_FAILURE;

	return EXIT_SUCCESS;
}
