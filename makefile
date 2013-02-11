all:
	swipl -o test -g test -c test.pl graphs.pl
run:
	./test
