#!/bin/sh
#
# Make the archivefile for Make mockbuild
# Called from the arhcivefile rule in common/Makefile.common
#
NAME=$(basename `pwd`)
VER_REL=$(rpm -q --qf "%{VERSION}\n" --specfile ${NAME}.spec | head -n 1)
#ARCHIVEFILE=$(cat ${NAME}.spec | grep -e '^[S|s]ource' | sed -r 's/^[S|s]ource[0-9]?:\s?//' | xargs basename)
#ARCHIVEFILE=$(rpm --queryformat "${ARCHIVEFILE}\n" --specfile ${NAME}.spec | head -n 1)
ARCHIVEFILE=$(cat archivefilename)
TREEPATH="$NAME-$VER_REL"
echo -e "\n$NAME $ARCHIVEFILE  $TREEPATH"
echo -e "\nMaking archive file ${ARCHIVEFILE} `pwd`" ; \
if [ "${NAME#smeserver}" == "${NAME}" ] || [ "${NAME#e-smith}" == "${NAME}" ] ; then \
	tar -czf ${ARCHIVEFILE} ${TREEPATH} ;\
	ls -l ${ARCHIVEFILE} ;
else \
	echo "3rd party package should already be there"; \
	if [ ! -e "${ARCHIVEFILE}" ] ; then \ 
		$(error "Can't find 3rd party archive: ${ARCHIVEFILE} "); \
	else \
		echo "Found 3rd party ${ARCHIVEFILE}"; \
	fi ; \
fi
exit 0