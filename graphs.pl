:- dynamic edge_/2.
:- dynamic vertex_/1.
%create backup system for graphs so if invalid one entered old one is restored
setGraph(Vertices,Edges) :-
	setVertices(Vertices),
	setEdges(Edges).
setVertices([]) :-
	vertex_(X) ->
	(
		retract(vertex_(X)),
		setVertices([])
	);
	true.
setVertices([Vertex|Others]) :-
	setVertices(Others),
	asserta(vertex_(Vertex)).
node(X) :- vertex(X).
vertex(X) :- vertex_(X).
setEdges([]) :-
	edge_(X,Y) ->
	(
		retract(edge_(X,Y)),
		setEdges([])
	).
setEdges([]).
setEdges([[X,Y]|Others]) :-
	vertex_(X),
	vertex_(Y),
	setEdges(Others),
	asserta(edge_(X,Y)).
edge(X,X).
edge(X,Y) :- edge_(X,Y).
edge(X,Y) :- edge_(Y,X).
edges(X,[Y|List]) :-
	edge(X,Y),
	edges(X,List).
edges(_,[]).
path(X,Y) :- edge(X,Y).
path(X,Y) :- path(X,Y,[]).
path(X,X,_).
path(X,Y,_):- edge(X,Y).
path(X,Y,Visited) :- 
	edge(X,Z),
	not(member(Z,Visited)),
	path(Z,Y,[X|Visited]).
degree(Vertex,Degree) :-
	findall(Edge,edge(Vertex,Edge),Edges),
	length(Edges,Degree).
size(Size) :-
	degree(_,Size).
complement(Vertices,Edges) :-
	var(Vertices),
	findall(Vertex,vertex(Vertex),Vertices),
	findall([A,B],(member(A,Vertices),member(B,Vertices),not(edge(A,B))),Edges).
complement(Vertices,Edges) :-
	nonvar(Vertices),
	findall([A,B],(member(A,Vertices),member(B,Vertices),not(edge(A,B))),Edges).
