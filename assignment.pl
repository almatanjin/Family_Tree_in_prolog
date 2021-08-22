male(hasan).
male(salman).
male(alif).
male(rokon).
male(raju).
male(sovo).
male(jack).
male(hanif).
male(ahmed).
male(rami).
male(rahi).
male(shaan).
male(shawon).
male(john).
male(zidan).
male(pitu).



female(somiya).
female(hena).
female(proma).
female(any).
female(sara).
female(pia).
female(richa).
female(kaira).
female(sohana).
female(hasina).
female(kakoly).
female(jessi).
female(alma).
female(nir).
female(prena).
female(shila).
female(nora).
female(megha).
female(joya).
female(rita).


parent(hasan,salman).
parent(hasan,alif).
parent(somiya,salman).
parent(somiya,alif).
parent(salman,sara).
parent(salman,sovo).
parent(proma,sara).
parent(proma,sovo).
parent(alif,rokon).
parent(alif,raju).
parent(any,rokon).
parent(any,raju).
parent(sara,hanif).
parent(sara,kakoly).
parent(jack,kakoly).
parent(jack,hanif).
parent(sohana,rami).
parent(sohana,rahi).
parent(raju,rami).
parent(raju,rahi).
parent(hanif,alma).
parent(hanif,shaan).
parent(hasina,alma).
parent(hasina,shaan).
parent(kakoly,shawon).
parent(ahmed,shawon).
parent(jessi,shila).
parent(rahi,shila).
parent(jessi,rita).
parent(rahi,rita).
parent(shaan,joya).
parent(nir,joya).
parent(shawon,zidan).
parent(prena,zidan).
parent(shila,nora).
parent(shila,megha).
parent(john,nora).
parent(john,megha).
parent(kakoly,richa).
parent(ahmed,richa).
parent(hena,pitu).
parent(zidan,pitu).


couple(hasan,somiya).
couple(somiya,hasan).
couple(salman,proma).
couple(proma,salman).
couple(alif,any).
couple(any,alif).
couple(jack,sara).
couple(sara,jack).
couple(sovo,pia).
couple(pia,sovo).
couple(sohana,raju).
couple(raju,sohana).
couple(hanif,hasina).
couple(hasina,hanif).
couple(ahmed,kakoly).
couple(kakoly,ahmed).
couple(rami,kaira).
couple(kaira,rami).
couple(rahi,jessi).
couple(jessi,rahi).
couple(shaan,nir).
couple(nir,shaan).
couple(shawon,prena).
couple(prena,shawon).
couple(john,shila).
couple(shila,john).
couple(hena,zidan).
couple(zidan,hena).



%RULES

husband(X,Y):-
    couple(X,Y),male(X).

wife(Y,X):-
    couple(X,Y),female(Y).

mother(X,Y):-
    parent(X,Y),female(X).

father(X,Y):-
    parent(X,Y),male(X).

child(X,Y):-
    parent(Y,X).

son(X,Y):-
   child(X,Y),male(X).

daughter(X,Y):-
    child(X,Y),female(X).

sibling(X,Y):-
    parent(Z,X),
    parent(Z,Y),
    X\=Y.

sister(X,Y):-
    sibling(X,Y),female(X),X\=Y.

brother(X,Y):-
    parent(Z,X),parent(Z,Y),male(X),X\=Y.

uncle(X,Y):-
       brother(X,Z),parent(Z,Y).

aunt(X,Y):-
    sister(X,Z),parent(Z,Y).

parent_in_law(X,Y):-
    parent(X,Z),couple(Z,Y).

mother_in_law(X,Y):-
    mother(X,Z),couple(Y,Z).

father_in_law(X,Y):-
    father(X,Z),couple(Y,Z).

sister_in_law(X,Y):-
    brother(Z,Y),couple(Z,X).

brother_in_law(X,Y):-
    sister(Z,Y),couple(Z,X).

son_in_law(X,Y):-
    daughter(Z,Y),couple(X,Z).

daughter_in_law(X,Y):-
    son(Z,Y),couple(X,Z).

nephew(X,Y) :-
    aunt(Y,X) , male(X).

nephew(X,Y) :-
    uncle(Y,X),male(X).

niece(X,Y) :-
    aunt(Y,X), female(X).

niece(X,Y) :-
    uncle(Y,X) , female(X).

grandparent(X,Y):-
    parent(X,Z),parent(Z,Y).

grandfather(X,Y):-
    grandparent(X,Y),male(X).

grandmother(X,Y):-
    grandparent(X,Y),female(X).

grandchild(X,Y):-
    grandparent(Y,X).

grandson(X,Y):-
    grandchild(X,Y),male(X).

granddaughter(X,Y):-
    grandchild(X,Y),female(X).

greatgrandparent(X,Y):-
    parent(Z,Y),parent(P,Z),parent(X,P).

greatgrandmother(X,Y):-
    greatgrandparent(X,Y),female(X).

greatgrandfather(X,Y):-
    greatgrandparent(X,Y),male(X).

greatgrandchild(X,Y):-
    greatgrandparent(Y,X).

greatgrandson(X,Y):-
    greatgrandparent(Y,X),male(X).

greatgranddaughter(X,Y):-
    greatgrandchild(X,Y),female(X).

great_greatgrandparent(X,Y):-
    parent(W,Y),parent(Z,W),parent(P,Z),parent(X,P).

great_greatgrandfather(X,Y):-
    great_greatgrandparent(X,Y),male(X).

great_greatgrandmother(X,Y):-
    great_greatgrandparent(X,Y),female(X).

great_greatgrandchild(X,Y):-
    great_greatgrandparent(Y,X).

great_greatgrandson(X,Y):-
    great_greatgrandchild(X,Y),male(X).

great_greatgranddaughter(X,Y):-
    great_greatgrandchild(X,Y),female(X).
great_great_greatgrandparent(X,Y):-
    parent(Z,Y),parent(P,Z),parent(W,P),parent(Q,W),parent(X,Q).

first_cousin(X,Y):-
    grandparent(Z,X),grandparent(Z,Y),\+sibling(X,Y),X\=Y.

first_degree_once_removed(X,Y):-
    first_cousin(X,Z),parent(Z,Y).

first_degree_once_removed(X,Y):-
    first_cousin(Z,Y),parent(Z,X).

first_degree_twice_removed(X,Y):-
    first_cousin(X,Z),grandparent(Z,Y).

first_degree_twice_removed(X,Y):-
    grandparent(Z,X),first_cousin(Z,Y).

first_degree_third_removed(X,Y):-
    first_cousin(X,Z),greatgrandparent(Z,Y).

first_degree_third_removed(X,Y):-
    first_cousin(Y,Z),greatgrandparent(Z,X).

first_degree_fourth_removed(X,Y):-
     first_cousin(X,Z),great_greatgrandparent(Z,Y).

first_degree_fourth_removed(X,Y):-
     first_cousin(Y,Z),great_greatgrandparent(Z,X).

second_cousin(X,Y):-
    greatgrandparent(Z,X),greatgrandparent(Z,Y),\+first_cousin(X,Y),\+sibling(X,Y),X\=Y.

second_degree_once_removed(X,Y):-
    second_cousin(Z,X),parent(Z,Y).

second_degree_once_removed(X,Y):-
    second_cousin(Z,Y),parent(Z,X).

second_degree_twice_removed(X,Y):-
    second_cousin(Z,X),grandparent(Z,Y).

second_degree_twice_removed(X,Y):-
    second_cousin(Z,Y),grandparent(Z,X).

second_degree_third_removed(X,Y):-
     second_cousin(Z,X),greatgrandparent(Z,Y).

second_degree_third_removed(X,Y):-
     second_cousin(Z,Y),greatgrandparent(Z,X).

third_cousin(X,Y):-
    great_greatgrandparent(Z,X),great_greatgrandparent(Z,Y),\+greatgrandparent(X,Y),\+second_cousin(X,Y),\+first_cousin(X,Y),\+sibling(X,Y),X\=Y.

third_degree_once_removed(X,Y):-
    third_cousin(X,Z),parent(Z,Y).

third_degree_once_removed(X,Y):-
    third_cousin(Y,Z),parent(Z,X).

third_degree_twice_removed(X,Y):-
    third_cousin(X,Z),grandparent(Z,Y).

third_degree_twice_removed(X,Y):-
    third_cousin(Y,Z),grandparent(Z,X).





