= Disjunkte mængder (Union-Find)
// Del B — Algoritmer og Datastrukturer · slides: disjointSetsSlides


== Partition
En partition (på dansk en disjunkt opdeling) af en mængde $S$ er en samling
ikke-tomme delmængder, som er disjunkte og tilsammen udgør hele mængden $S$:
- $A_i != emptyset$ for alle $i$ – Ingen af delmængderne må være tomme
- $A_i inter A_j = emptyset$ for $i != j$ – Delmængderne skal være disjunkte, altså de må ikke overlappe. Et element fra mængden $S$ kan kun ligge i én af delmængderne
- $A_1 union A_2 union ... union A_k = S$ – Delmængderne skal dække hele mængden $S$ tilsammen.

*Eksempel:*
$ S = {a, b, c, d, e, f, g, h} $
Med følgende partition:
$ {a, b}, {e, f}, {c, d, g, h} $


== Operationer
Disjoint sets giver følgende operationer:
- *Find-set(x)* – Returnerer et ID for den mængde, $x$ tilhører
- *Union(x,y)* – Slår to mængder sammen til én, beholder én header, og opdaterer alle pointere i den anden liste til at pege på den nye header.
- *Make-set(x)* – Opretter en ny mængde med kun elementet $x$

\*Mængde refererer til en "bid" eller "sub-mængde" af den totale mængde $S$.


== Implementering med lænkede lister
Disjoint sets er implementeret ved hjælp af lænkede lister, hvor hver mængde har
sin egen lænkede liste og deres første element (headeren) indeholder deres ID.

#figure(
  image("figures/disjointsetvisual.png", width: 75%),
  caption: [(a) To mængder $S_1$ og $S_2$ som lænkede lister. (b) Resultatet efter en union.],
)

- Find-Set: $O(1)$
- Make-Set: $O(1)$
- Union: $O(n)$

Det er en god idé at når man laver en union på to lister, at man så sørger for at
det er den korteste liste der bliver lænket på den længste. På den måde undgår man
at skulle ændre så mange pointere som muligt. I værste fald kan en hel sekvens af
unions køretid nemlig vokse til $O(n^2)$.


== Implementering med træer
Man kan også repræsentere hver disjunkte mængde som hvert sit træ, hvor roden er
ID'et (headeren):

#figure(
  image("figures/disjointsettreevisual.png", width: 70%),
  caption: [(a) To mængder som træer. (b) Resultatet efter en union.],
)

- Find-Set(x): gå til rod
- Make-Set(x): opret et nyt træ
- Union(x,y): gør ét træ til barn af andet træ


== Union by rank
For disjunkte mængder i træer kan man med fordel bruge union by rank. Her får
hver rod et tal (rank), der repræsenterer træets højde. Ved union lader man altid
roden med lavest rank blive barn af roden med højst rank. Er rank uafgjort får $y$
$x$ som barn og $y$'s rank øges med 1.


== Path compression (stikomprimering)
Path compression bruges når man laver Find-Set(x), ved at flade stien ud. Alle de
knuder man passerer på vejen til roden, bliver gjort til direkte børn af roden,
hvilket gør fremtidige opslag af disse elementer øjeblikkelige.

#figure(
  image("figures/pathcompression.png", width: 75%),
  caption: [Path compression: (a) før og (b) efter — alle knuder på stien peger nu direkte på roden.],
)


== Pseudokode
Pseudokode for omtalte funktioner:

#figure(
  image("figures/disjointsetfunctionspseudo.png", width: 80%),
  caption: [`MAKE-SET`, `UNION`, `FIND-SET` (med path compression) og `LINK` (med union by rank).],
)


== Eksamenstips og faldgruber
_Noter tilføjes (tegne skoven efter en sekvens af operationer)._
