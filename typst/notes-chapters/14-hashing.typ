= Hashing og ordbøger (dictionaries)
// Del B — Algoritmer og Datastrukturer · slides: dictionarySlides


== Grundidé og hashfunktioner
I hashing antager vi, at keys er heltal op til en max grænse $M$. Dvs. at vi har et univers af mulige heltalskeys:

$ U = {0, 1, 2, dots, M} $

I hashing benytter vi også idéen om at bruge keys som indekser i et array (ligesom counting sort).

#figure(
  image("figures/hashing.png", width: 75%),
  caption: [Direkte adressering: hver mulig key har sit eget slot i tabellen $T$.],
)

Dette tager $O(1)$ tid for Search, Insert og Delete.

Der er dog et problem. Denne idé kan nemt generere pladsspild, fordi array-størrelse er $|U|$, mens antallet $n$ af gemte elementer ofte er meget mindre. Et eksempel kunne være at vi skal gemme 5 CPR-numre. Dvs. keys på formen xxxxxx-xxxx, der kan ses som heltal i $U$. Her er $|U| = 10^10$, men $n = 5$. Det er kæmpe spild.

En hashfunktion bruges til at løse dette problem, ved at mappe keys fra det store heltalsunivers $U$ til et mindre:

$ h: U arrow.r {0, 1, 2, dots, m-1} $

Her er $m$ den ønskede array-størrelse. Ofte vælges $m approx n$, så der ikke bruges mere plads på array'et end på elementerne selv. Et simpelt eksempel på en hashfunktion:

$ h(k) = k mod m $

Konkret eksempel hvor $m = 41$:

#figure(
  image("figures/hashingexample.png", width: 85%),
  caption: [Hashværdier for $h(k) = k mod 41$.],
)

Hashfunktioner løser pladsproblemet, men skaber samtidig et nyt problem: to keys kan hashe til samme array index (kollision).

#figure(
  image("figures/hashingcollision.png", width: 80%),
  caption: [Kollision: både $479869$ og $46$ hasher til slot $5$.],
)


== Kædning (chaining)
Løsningen på dette er chaining. Her indeholder en array-indgang starten på en lænket liste med alle de indsatte elementer, hvis key hasher til denne array-indgang. Prisen her er, at tiden for operationerne Search og Delete stiger fra $O(1)$ til $O(n)$. Insert er stadig $O(1)$.


== Åben adressering
En anden løsning end chaining er open addressing. Her forsøger vi at finde et tomt slot i selve array'et.

#figure(
  image("figures/openaddressing.png", width: 90%),
  caption: [Åben adressering: linear probing og double hashing. $h_1$ og $h_2$ er to hash-funktioner.],
)


== Fyldningsgrad (load factor) og ydeevne
Vi ønsker at en hash-funktion spreder keys fra det konkrete input godt ud over ${0, 1, 2, dots, m-1}$, så der bliver så få kollisioner som muligt. En god hash-funktion skal derfor gerne forsøge at mappe keys til indekser tilfældigt. Man kan dog ikke undgå for nogen hash-funktion at man mindst kan finde $|U| \/ m$ keys, som kolliderer. Ofte er $|U| \/ m >= n$, hvilket resulterer i worst case tiden $O(n)$.

I praksis kan man regne med at hashing understøtter Search, Insert, og Delete i $O(1)$ køretid medmindre man er meget uheldig.


== Eksamenstips og faldgruber

=== Genvej: Mulige værdier af $h'(x)$ ved linear probing
*Opgavetype.* Givet en hashtabel der bruger linear probing, og et element der er
blevet indsat og endt på et bestemt indeks — find ud af hvilke værdier af den
auxiliary hash-funktion $h'(x)$ der kunne have ført til dette resultat.

*Genvejen (ingen beregning nødvendig):*
- Find indekset hvor elementet faktisk endte (landingspladsen).
- Gå baglæns fra landingspladsen, med wrap-around hvis nødvendigt.
- Hver plads du møder, som er optaget, er en gyldig kandidat for $h'(x)$ (inklusive landingspladsen selv).
- Så snart du møder en ledig plads (gående baglæns) → STOP. Denne plads er ikke gyldig.
  - Alle pladser endnu længere tilbage er automatisk udelukkede også, fordi probing fra dem ville være stoppet ved den ledige plads i stedet for at nå frem til landingspladsen.
