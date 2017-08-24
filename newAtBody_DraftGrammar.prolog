atBody(AtBodyStr)			-->	atBodyAlternatives(List1), moreAtBodyAlternatives(ListOfLists),
						{
							addToHead(ListOfLists, List1, List),
							
							prod(List, AltBodyLists),
							findall(AltBodyStr, (member(AltBodyList, AltBodyLists), atomics_to_string(AltBodyList, ",\n\t", AltBodyStr)), AltBodyStrs),
							atomics_to_string(AltBodyStrs, "^", AtBodyStr)
						}.

moreAtBodyAlternatives(List)		-->	",", space, atBodyAlternatives(List1), moreAtBodyAlternatives(ListOfLists),
						{
							addToHead(ListOfLists, List1, List)
						}.
moreAtBodyAlternatives([])		-->	[].

atBodyAlternatives([BPStr])		-->	atBodyPart(BPStr).
atBodyAlternatives(List)		-->	"(", atBodyPart(BPStr1), space, "or", space, atBodyPart(BPStr2), moreAtBodyParts(BPList), ")",
						{
							addToHead(BPList, BPStr2, BPTemp),
							addToHead(BPTemp, BPStr1, List),
						}.

moreAtBodyParts(List)			-->	space, "or", space, atBodyPart(BPStr), moreAtBodyParts(BPList),
						{
							addToHead(BPList, BPStr, List)
						}.
moreAtBodyParts([])			-->	[].
