### General info

SimplEC is a simplified [Event Calculus](https://en.wikipedia.org/wiki/Event_calculus) dialect. An event description in simplEC can be compiled into the RTEC format and subsequently used for narrative assimilation. SimplEC has been developed with view to making the writing of Composite Event patterns for Event Recognition purposes easier.

### License

SimplEC comes with ABSOLUTELY NO WARRANTY. This is free software, and you are welcome to redistribute it under certain conditions; see the [GNU Lesser General Public License v3 for more details](http://www.gnu.org/licenses/lgpl-3.0.html).

### Prerequisites

1. SWI-Prolog (preferably version 7.x)
1. [GraphViz](http://www.graphviz.org/)
1. [RTEC](https://github.com/aartikis/RTEC)
1. Download simplEC.prolog, compile.sh

### Compiling

To compile a set of simplEC rules into the compiled RTEC format, please make sure that you include the source files of RTEC in your working directory in a subdirectory named \"RTEC/\". Afterwards, you can execute the corresponding bash script, as follows:

	user@machine:your/working/directory$ bash compile.sh sample_rules.txt 16.0

SimplEC needs 2 arguments as input: The input rules in simplEC and the desired font size in the dependency graph. In the above example the SimplEC statements are in the "sample_rules.txt" file and the desired font size in the resulting dependency graph is 16.0. The procedure produces 6 files in the output:

1. RTEC-compatible action descriptions.
1. RTEC-compatible declarations.
1. Compiled action descriptions.
1. Dependency graph (png format).
1. Dependency graph (GraphViz source).
1. Log file reporting any compilation errors.

### Related publications

* Vlassopoulos C. and Artikis A. [Towards A Simple Event Calculus for Run-Time Reasoning](http://ceur-ws.org/Vol-2052/paper20.pdf) Proceedings of the Thirteenth International Symposium on Commonsense Reasoning, COMMONSENSE 2017, London, UK, November 6-8, 2017.

### Relevant software

* [RTEC](https://github.com/aartikis/RTEC)
* [ScaRTEC](https://github.com/kontopoulos/ScaRTEC)
