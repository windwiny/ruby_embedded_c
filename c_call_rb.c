#include <stdio.h>
#include "ruby.h"

int main(int argc, char* argv[]) {
	ruby_setup();
	ruby_init_loadpath();
   
	int error;
	char *ss;
	if (argc>1)
	{
		ss = argv[1];
	}else
	{	ss = "puts 'input ruby code to argv[1]' ";
	}
	rb_eval_string_protect(ss, &error);
	printf("=%d\n", error);
	return 0;
}
