test:-
	format('Hello World!~n'),
	setGraph([a,b,c,d,e],[[a,b],[b,c],[c,d],[d,e],[a,e],[c,e]]),
	halt.
