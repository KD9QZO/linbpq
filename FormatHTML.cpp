// FormatHTML.cpp : Defines the entry point for the console application.
//

#include <stdio.h>

#if (!defined(FORMATHTML_IN_FILE) || defined(__DOXYGEN__))
/**
 * \brief The filename used for input by FormatHTML.cpp
 *
 * \note The default value is <tt>D:/AtomProject/test.html</tt>
 */
#define FORMATHTML_IN_FILE "D:/AtomProject/test.html"
#endif

#if (!defined(FORMATHTML_OUT_FILE) || defined(__DOXYGEN__))
/**
 * \brief The filename used for output by FormatHTML.cpp
 *
 * \note The default value is <tt>D:/AtomProject/test.html.c</tt>
 */
#define FORMATHTML_OUT_FILE "D:/AtomProject/test.html.c"
#endif


int main() {
	FILE *fp;
	FILE *fp2;
	char str[256];
	char newstr[256];
	char *ptr;
	char *inptr;

	/* opening file for reading */
	fp = fopen(FORMATHTML_IN_FILE, "r");
	fp2 = fopen(FORMATHTML_OUT_FILE, "w");

	if(fp == NULL) {
		perror("Error opening file");
		return(-1);
	}

	while (fgets (str, 256, fp) != NULL) {
		// Replace any " with \" and add " on front and \r\n" on end
		char c;
		ptr = newstr;
		inptr = str;

		c = *(inptr++);
		*(ptr++) = '"';

		while (c && c != 10) {
			if (c == '"')
				*(ptr++) = '\\';

			*(ptr++) = c;
			c = *(inptr++);
		}

		*(ptr++) = '\\';
		*(ptr++) = 'r';
		*(ptr++) = '\\';
		*(ptr++) = 'n';
		*(ptr++) = '"';
		*(ptr++) = 10;
		*(ptr++) = 0;

		puts(newstr);
		fputs(newstr, fp2);
	}

	fclose(fp);
	fclose(fp2);

	return (0);
}

