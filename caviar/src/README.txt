
*************
* RTEC v1.0 *
*************

RTEC has been tested under YAP Prolog 6.2.

***************
* RTEC files: *
***************

-RTEC.prolog. This is the main file.
-compiler.prolog. This is the compiler of RTEC. The event descriptions developed by the user are translated into a representation that allows for efficient reasoning.
-processSimpleFluents.prolog. This module processes and caches the intervals of simple fluents.
-processSDFluents.prolog. This module processes and caches the intervals of statically determined fluents.
-processEvents.prolog. This module processes and caches the time-points of events.
-inputModule.prolog. This module includes the 'forget' mechanism of RTEC and the processing mechanism of input entities (input events and fluents).
-utilities/interval-manipulation.prolog. This is the module of the interval manipulation constructs.
-utilities/amalgamate-periods.prolog. This file includes a predicate for period amalgamation.

***************
* Compilation *
***************

The user produces two files:
(i) The event description.
(ii) The declarations of the event description (declaration of simple fluents, statically determined fluents, etc).

To compile the event description, load RTEC.prolog and invoke the following predicate:

compileEventDescription(+Declarations, +InputDescription, -OutputDescription).

Reasoning should be performed on the compiled event description (see the third argument of compileEventDescription/3), along with the declarations (see the first argument of compileEventDescription/3).

More precisely, terminate the Prolog session in which compilation was performed, and start a new one loading the compiled event description, the declarations and the RTEC files.

************
* Examples *
************

In the 'examples' folder there are formalisations of the following application domains:

-City Transport Management (CTM): the PRONTO dataset.
-Public Space Surveillance: the CAVIAR dataset. 

For each example, I have included the event description developed by the user (that is, the event description prior to compilation), the declarations, and the compiled event description. The 'experiments' folder includes datasets for the corresponding example and sample queries (mass-queries.prolog). Load directly the mass-queries.prolog in order to experiment with RTEC. *Please note the instructions on top of the query files (mass-queries.prolog).*

Details about the CTM experiments may be found at:
http://users.iit.demokritos.gr/~a.artikis/publications/artikis-DEBS12.pdf

A preliminary account of the CAVIAR event description may be found at:
http://users.iit.demokritos.gr/~a.artikis/publications/eimm10-artikis.pdf


