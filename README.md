# webtest

This project shows how to use gradle to compile, package and deploy an Heirloom PaaS ETP project. 

It does this by downloading the compiler (ecobol.exe) and runtime (ecobol.jar, etrans.jar) as an artifact from the jfrog repository.

The ecobol.gradle "plug-in" then adds a compileCobol task to the project. 

ecobol.dir in the project root is used to control the directives for compilation, including specifying the copydir

The convention is that the source code is held under "src/main/cobol/program" and copy files are "src/main/cobol/copydir"
