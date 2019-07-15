all: mdocupdate intellisense

# step 1, compile the library
code.dll: code.cs
	csc code.cs -target:library

code2.dll: code.cs
	csc code.cs -target:library -out:code2.dll -define:V2

restore: 
	nuget install mdoc -OutputDirectory packages -ExcludeVersion

# step 2, prepare the frameworks
mdocprepare: restore code.dll code2.dll
	mkdir -p tmp
	mkdir -p tmp/LibraryName
	mkdir -p tmp/LibraryNameV2

	cp frameworks.xml tmp/
	cp code.dll tmp/LibraryName/
	cp code.dll tmp/LibraryNameV2/
	cp code2.dll tmp/LibraryNameV2/

# step 3, do the mdoc update
mdocupdate: mdocprepare
	mono packages/mdoc/tools/mdoc.exe update -fx tmp/frameworks.xml -out docs -lang docid

intellisense: mdocupdate
	mkdir -p intellisense
	mono packages/mdoc/tools/mdoc.exe export-msxdoc docs
	mv code.xml intellisense/
	mv code2.xml intellisense/
	mv NamespaceSummaries.xml intellisense/

.PHONY: mdocprepare mdocupdate restore