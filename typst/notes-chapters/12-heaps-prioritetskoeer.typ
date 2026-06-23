= Heaps og prioritetskøer
// Del B — Algoritmer og Datastrukturer · slides: pqSlides


== Prioritetskøer
En datastruktur, hvor elementerne er en nøgle fra et ordnet univers samt evt.
yderligere data. Et ordnet univers refererer til en mængde af værdier hvor man kan
sammenligne to vilkårlige elementer og afgøre, hvilket der er størst.

Prioritetskøer tilbyder følgende operationer:
- *Extract-Max():* fjerner og returnerer elementet med størst nøgle.
- *Insert(e):* tilføjer et element.

Det er muligt at sortere en liste ved blot at bruge $n$ `Insert()` og $n$ `Extract-Max()`.

Derudover har prioritetskøer yderligere følgende operationer:
- *Increase-Key(r, k):* opdaterer nøglen for et element (refereret via r) til den største af $k$ og den gamle nøgle.
- *Build(L):* opbygger en prioritetskø fra en hel liste af elementer på én gang.

Derudover er der følgende trivielle operationer som er gældende for alle
datastrukturer:
- *CreateNewEmpty()*
- *DestructEmpty()*
- *IsEmpty?()*


== Implementation med en heap
Prioritetskøer kan implementeres på forskellige måder, som giver samme førnævnte
operationer. En måde er ved at benytte heapstrukturen fra Heapsort (se kapitlet om
Sortering for heap-egenskaben og array-repræsentationen).
- *Extract-Max:* Er essentielt hvad der bruges under anden del af Heapsort.
- *Build:* Brug Heapify gentagne gange bottom-up.

De to sidste operationer benytter ikke noget funktionalitet fra heapsort:
- *Increase-Key:* Ændre nøgle for element og genopret heaporden. Så længe elementet er stærkere end forælder → skift plads.

#figure(
  image("figures/pqincreasekey.png", width: 75%),
  caption: [`Increase-Key`: den opdaterede nøgle bobler op mod roden til heaporden er genoprettet.],
)

Køretid $O(log n)$.

- *Insert:* indsæt det nye element sidst og genopret heaporden præcis som i increase-key.

Også køretid på $O(log n)$.


== Sammenligning af implementationer
Køretider for forskelligt implementerede versioner af prioritetskøer:

#figure(
  image("figures/differentpqs.png", width: 90%),
  caption: [Køretider for prioritetskø-operationer ved heap, usorteret liste og sorteret liste.],
)


== Eksamenstips og faldgruber
_Noter tilføjes._
