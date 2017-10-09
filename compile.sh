#!/bin/bash

if [ $# != 4 ];
then
	printf "Please provide 4 arguments: The input SimplEC file, as well as the desired names for the compiled event description, the declarations and the dependency graph files.\n\n"
	exit 100
fi

simplec=$1
evdescomp=$2
decl=$3
graph=$4

swipl -l simplEC.prolog -g "simplEC('$1','event_description.prolog','$3', '$4')" -g "halt"
swipl -l RTEC.prolog -g "compileEventDescription('$3', 'event_description.prolog', 'tmp.pl')" -g "halt"
printf ":- ['RTEC.prolog'].\n:-['$3'].\n\n" > $2
cat tmp.pl >> $2
rm -f tmp.pl

exit 0
