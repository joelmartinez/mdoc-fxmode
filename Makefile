all: mdocupdate

# step 1, compile the library
code.dll: code.cs
	csc code.cs -target:library

restore: 
	nuget install mdoc -OutputDirectory packages -ExcludeVersion

# step 2, prepare the frameworks
mdocprepare: restore code.dll
	mkdir -p tmp
	mkdir -p tmp/LibraryName

	cp frameworks.xml tmp/
	cp code.dll tmp/LibraryName/

# step 3, do the mdoc update
mdocupdate: mdocprepare
	mono packages/mdoc/tools/mdoc.exe update -fx tmp/frameworks.xml -out docs -lang docid


.PHONY: mdocprepare mdocupdate restore