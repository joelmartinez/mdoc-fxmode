# How to use Frameworks Mode

mdoc's "frameworks mode" is a way to maintain library documentation that 
has multiple variations. For many reasons, each "framework" can and often
does have variations; versioning is the simplest example of variations in a framework,
sometimes it's different platform-specific types, sometimes it's different attributes, 
and sometimes it's as simple asdifferent parameter names due to legacy integrations 
of multiple codebases.

In any case, this sample shows the simplest possible use of frameworks mode.
Start by looking at the artifacts stored in the repository:

- `docs` folder ... this contains the EcmaXML that is built. Note the [FrameworksIndex](docs/FrameworksIndex) folder. This is the principal differentiator between a regular ecmaXML repository, and one that was created with frameworks mode.
- [`frameworks.xml`](frameworks.xml) file ... this contains the instructions for what "frameworks" `mdoc update` will use, and where the assemblies will be. 
- "the code": this is here in this sample, in the form of `code.cs` and the `code.dll` target in the makefile ... but in a real project, would obviously be whatever mixture of msbuild, or other build technologies you choose.

In the [Makefile](Makefile). There are three steps essential steps.

1. First, compile the library ... again, this is just a simple example for this sample, and in *your* project would simply be the output artifacts of your build process.
2. Second, prepare the frameworks. In our case, we only have one "framework", so the `mdocprepare` target of the makefile simply makes a folder named `LibraryName` in a tmp location, and then copies the `frameworks.xml` and assembly (`code.dll`, in this case).
3. Third, run `mdoc update` in frameworks mode. This differs from a regular/traditional run of mdoc update in two ways:
    - Instead of passing in a list of assemblies, we pass the path to the `frameworks.xml` file using the `-fx` (or `-frameworks`, if you'd really prefer) cli parameter.
    - We also add the `-lang docid` cli parameter. This adds an additional set of signatures to help match the IDs in the new framework index file.

_Note:_ You will need to install `make`, `mono`, and `nuget` if you are running this on linux/mac/wsl
