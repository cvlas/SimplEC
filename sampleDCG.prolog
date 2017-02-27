cliche -->
    thing(Type, Opposite),
    " is a ", 
    Type, 
    " trapped in a ", 
    Opposite, 
    " body.".
    
thing("Unix OS", "Windows'") --> "Cygwin".
thing("dog", "cat's") --> "Fluffy".
thing("fish", "hooman") --> "Bob the swimmer".

type_of_thing --> "Unix OS".
type_of_thing --> "dog".
type_of_thing --> "fish".

opposite_type_of_thing --> "Windows'".
opposite_type_of_thing --> "cat's".
opposite_type_of_thing --> "human".
