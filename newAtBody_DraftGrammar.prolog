atBody					-->	atBodyAlternatives(List1), moreAtBodyAlternatives(ListOfLists),
						{
							addToHead(ListOfLists, List1, List),
							
							prod(List, AltBodyLists),
							forall(member(AltBodyList, AltBodyLists), (atomics_to_string(AltBodyList, ",\n\t", AltBodyStr), writeln(AltBodyStr)))
						}.

moreAtBodyAlternatives(List)		-->	",", space, atBodyAlternatives(List1), moreAtBodyAlternatives(ListOfLists),
						{
							addToHead(ListOfLists, List1, List)
						}.
moreAtBodyAlternatives			-->	[].

atBodyAlternatives			-->	atBodyPart.
atBodyAlternatives			-->	"(", atBodyPart, space, "or", space, atBodyPart, moreAtBodyParts, ")".

moreAtBodyParts				-->	space, "or", space, atBodyPart, moreAtBodyParts.
moreAtBodyParts				-->	[].
