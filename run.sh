#!/usr/bin/env bash

MY_MVN="./mvnw"
DEPS="dependency:purge-local-repository clean dependency:resolve dependency:resolve-plugins dependency:tree dependency:sources dependency:analyze-dep-mgt dependency:analyze-report install"
SITE="site:site site:jar"

function dockerUp() {
    $MY_MVN docker-compose:up
}

function dockerDown() {
    $MY_MVN docker-compose:down
}

function doSetup() {
    $MY_MVN $DEPS $SITE
    $MY_MVN -Pliberty $DEPS $SITE liberty:package
    $MY_MVN -Pwildfly $DEPS $SITE cargo:uberwar
    $MY_MVN -glassfish $DEPS $SITE cargo:uberwar
    $MY_MVN -Ppayara $DEPS $SITE cargo:uberwar
    $MY_MVN -Ptomee $DEPS $SITE cargo:uberwar
    $MY_MVN -Parc-wildfly-managed $DEPS $SITE site:deploy
}

function doRun() {
		./mvnw -Pliberty
}

function main() {
	doSetup
	#doRun
}

main
