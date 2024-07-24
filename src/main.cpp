#include <boost/iostreams/device/mapped_file.hpp>
#include <boost/filesystem/operations.hpp>
#include <boost/filesystem/path.hpp>
#include <cstdlib>
#include <cstdint>
#include <ctime>

// It is just more efficient to have such a program.
// And it would be really difficult to do the same actions with existing commands.
// It would be better if gcc would just generate correct depndency files.
int32_t wmain(const int32_t argc, const wchar_t *const *const argv) {
	if (argc != 2) return EXIT_FAILURE;

	const boost::filesystem::path dependency = boost::filesystem::path{argv[1]};
	const time_t prev_write_time = boost::filesystem::last_write_time(dependency);
	{
		boost::iostreams::mapped_file file = boost::iostreams::mapped_file{dependency};
		if (!file.is_open()) return EXIT_FAILURE;

		// Works only on windows.
		// We make an assumption that after the first rule, more rules could be defined so we append our rules to file end.
		const char *const beg = file.const_data();
		const char *in = beg + dependency.size() + 3;
		char *out = const_cast<char *>(beg) + file.size();

	FIRST:
		switch (*++in) {
			case '\\':
				in += 4;
				[[fallthrough]];
			default:
				*out++ = *in;
				goto PREREQUISITE;
		}

	PREREQUISITE:
		switch (*++in) {
			default:
				*out++ = *in;
				goto PREREQUISITE;
			case ' ':
				*out++ = ' ';
				goto FIRST;
			case '\r':
				*out++ = ':';
				*out++ = ';';
				*out++ = '\r';
				*out++ = '\n';
				break;
		}

		file.resize(out - beg);
	}
	boost::filesystem::last_write_time(dependency, prev_write_time);

	return EXIT_SUCCESS;
}
