#!/bin/sh

# Twig-persist 2.0-beta3
mvn install:install-file -Dfile=src/main/webapp/WEB-INF/lib/twig-persist-2.0-beta3.jar -DgroupId=com.google.code.twig -DartifactId=twig-persist -Dversion=2.0-beta3 -Dpackaging=jar -DgeneratePom=true

# gaevfs revision 452
mvn install:install-file -Dfile=src/main/webapp/WEB-INF/lib/gaevfs-r452.jar -DgroupId=com.newatlanta -DartifactId=gaevfs -Dversion=r452 -Dpackaging=jar -DgeneratePom=true
mvn install:install-file -Dfile=src/main/webapp/WEB-INF/lib/gaevfs-test-r452.jar -DgroupId=com.newatlanta -DartifactId=gaevfs-test -Dversion=r452 -Dpackaging=jar -DgeneratePom=true

# appengine-java-io 0.1.0
mvn install:install-file -Dfile=src/main/webapp/WEB-INF/lib/appengine-java-io-0.1.0.jar -DgroupId=com.vobject -DartifactId=appengine-java-io -Dversion=0.1.0 -Dpackaging=jar -DgeneratePom=true

# appengine-java-io-metaclass 0.1.0
mvn install:install-file -Dfile=src/main/webapp/WEB-INF/lib/appengine-java-io-metaclass-0.1.0.jar -DgroupId=com.vobject -DartifactId=appengine-java-io-metaclass -Dversion=0.1.0 -Dpackaging=jar

# Run gae:unpack to place the google app engine sdk into your local .m2 repository
mvn gae:unpack

# Run mvn clean compile -P local to create a new local build
mvn clean compile -P local