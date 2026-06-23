= Dynamisk programmering
// Del B — Algoritmer og Datastrukturer · slides: dynamicProgrammingSlides, maxSumSlides


== Principper

=== Kombinatoriske optimeringsproblemer
En kombinatorisk struktur er noget, der er bygget op af mange enkeltdele, som legoklodser der sættes sammen til en mur. Et kombinatorisk optimeringsproblem er, når vi blandt alle de mulige måder at sætte delene sammen på, vil finde den bedste.

Eksempler:
- Hurtigste rute fra A til B
- Mest profitable pakning af lastbil
- Skema med mindst mulig undervisning efter klokken 16

=== Dynamisk programmering
En metode til at udvikle algoritmer til kombinatoriske optimeringsproblemer. Fungerer lidt som divide and conquer-metoden, da det er en rekursiv metode der opbygger løsninger til større problemer ud fra løsning til mindre problemer.

Dog, i modsætning til divide and conquer, reduceres delproblemets størrelse ofte kun med 1 frem for halvering, og det samme delproblem dukker op igen og igen frem for aldrig. Det resulterer derfor i at den naive rekursion er eksponentiel.

Tricket i dynamisk programmering er derfor at fremstille en tabel, der gemmer løsningen til hvert delproblem, så man kun løser det én gang. Det ændrer køretiden fra eksponentiel til polynomiel. Den svære del er så at finde den rekursive beskrivelse af løsningen. Når man først har den, er resten af processen (tabel-opbygning) nogenlunde ens fra problem til problem.

Man kan ofte finde rekursionen med to trin:
+ Find et mål for problemstørrelse — typisk et eller flere heltal der bliver indeks i en tabel.
+ Analysér strukturen — en optimal løsning kan ofte deles op i en "sidste del" og "resten". Resten må selv være en optimal løsning til et mindre problem af samme type.


== Gennemregnede eksempler

=== Max sum-problemet
Hvis vi har et array, kan vi være interesseret at finde et segment (sammenhængende del af array). Det kan desuden være at vi gerne vil have det segment, som resulterer i den største mulige sum.

#figure(
  image("figures/maxsumexample.png", width: 80%),
  caption: [Dette segment ville have summen $7$ — den størst mulige.],
)

I virkeligheden kan det være situationer, som aktieanalyse.

#figure(
  image("figures/stockexample.png", width: 75%),
  caption: [Aktieanalyse: daglige procentvise ændringer for et segment.],
)

Her arbejder vi i stedet med procenter, som skal ganges sammen for at give noget meningsfuldt resultat. Det oprindelige problem bliver nu til: hvilket segment har det største produkt af faktorer. Det er dog lidt mere besværligt.

Vi kan derfor med fordel bruge logaritmer, til at omdanne et produkt-problem til et sum-problem, så det dermed bliver lettere at håndtere. Eftersom logaritmer er en voksende funktion, gælder:

$ x < y arrow.r.double log x < log y $

Og fordi $log(a dot b) = log a + log b$ kan vi omskrive produktet af faktorer til en sum af logaritmer.

#figure(
  image("figures/producttosum1.png", width: 75%),
  caption: [Ændringerne som faktorer, der skal ganges sammen.],
)

#figure(
  image("figures/producttosum2.png", width: 75%),
  caption: [Efter logaritme-transformation bliver produktet til en sum — og problemet er igen et max sum-problem.],
)

Nu står vi dermed tilbage med et sum-problem, som vi startede med at nævne. Nu skal vi så finde summen for alle mulige segmenter, for at finde den der giver den største sum. Den naive løsning:

#figure(
  image("figures/maxsumnaivesolution.png", width: 60%),
  caption: [`MaxSum1`: den naive løsning med tre indlejrede løkker.],
)

Har en køretid på $O(n^3)$.

Det kan vi gøre bedre. Eftersom vi kender summen fra $i$ til $j - 1$, kan vi finde summen fra $i$ til $j$ ved blot at lægge ét tal mere til, i stedet for at summere hele segmentet igen:

#figure(
  image("figures/maxsum2.png", width: 60%),
  caption: [`MaxSum2`: genbrug af delsummen sparer den inderste løkke.],
)

Vi sparer dermed én løkke og får en køretid på $O(n^2)$. Vi kan gøre det endnu bedre.

Vi bemærker at hvis $x < y$, så gælder $x + c < y + c$. Altså, at lægge samme tal til alt bevarer rækkefølgen. Det kan også skrives:

$ max(x + c, y + c) = max(x, y) + c $

Derfor kan vi kigge på segmenter i bunker, således den nye bunke er lig den gamle bunke med alle segmenter, bare udvidet med den samme værdi.

#figure(
  image("figures/maxsum3.png", width: 60%),
  caption: [`MaxSum3`: kun én løkke ved at vedligeholde `maxEndingHere`.],
)

Hermed står vi tilbage med kun én løkke og dermed en køretid på $O(n)$.


=== Guldkæde-problemet (rod cutting)
Et eksempel på et problem der løses med dynamisk programmering, kan være, at en guldkæde kan sælges i forskellige længder af led, men prisen stiger ikke proportionelt med antal led pr. kæde. Vi skal finde den kombination af antal led pr. kæde der giver størst udbytte:

#figure(
  image("figures/dpchain1.png", width: 80%),
  caption: [Prisen $p_i$ for en kæde af længde $i$ — stiger ikke proportionelt.],
)

#figure(
  image("figures/dpchain2.png", width: 80%),
  caption: [Alle opdelinger af en kæde med 4 led; den bedste giver $5 + 5 = 10$.],
)

Her kan enhver opdeling af en kæde af længden $n$ ses som:
- Et sidste stykke af længde $i$
- En opdeling af resten (en kæde af længde $n - i$)

Her kan vi observere, at hvis hele opdelingen skal være optimal, så må opdelingen af resten også selv være optimal for sin egen mindre størrelse. Hvis der fandtes en bedre opdeling af resten, kunne man bruge den i stedet og dermed forbedre hele løsningen.

Vi kalder værdien af den bedste opdeling af en kæde af længden $n$ for $r(n)$, og vi ved at $r(0) = 0$. En kæde med 0 led er ikke noget værd.

Vi vil gerne skrive:

$ r(n) = p_i + r(n - i) $

Altså værdien = prisen for det sidste stykke plus den optimale værdi af resten. Problemet er vi ikke kender $i$ på forhånd. Her må vi prøve alle muligheder for $i$, og så tage det bedste:

#figure(
  image("figures/dpformula.png", width: 50%),
  caption: [Rekursionen for guldkæde-problemet med basistilfælde $r(0) = 0$.],
)

Den her formel er korrekt, men sådan en direkte rekursiv udregning er dårlig algoritmisk, eftersom rekursionstræet har $2^n$ knuder. Det resulterer i en køretid på $O(2^n)$.

For at undgå dårlig køretid, benytter vi os af en tabel over værdien af de optimale løsninger, så vi ikke går igennem hvert delproblem flere gange:

#figure(
  image("figures/dptable1.png", width: 60%),
  caption: [Tabellen $r(n)$ initialiseres med basistilfældet $r(0) = 0$.],
)

Så kan vi fylde hvert felt ud med

#figure(
  image("figures/dpformula2.png", width: 45%),
  caption: [Hvert felt udfyldes ud fra de allerede beregnede felter.],
)

hvis de foregående felter er fyldt ud. Det giver altså en afhængighed som kan vises således:

#figure(
  image("figures/dpdependency.png", width: 60%),
  caption: [$r(7)$ afhænger af alle de tidligere felter $r(0), dots, r(6)$.],
)

Pseudokoden for denne løsning:

#figure(
  image("figures/dppseudo.png", width: 45%),
  caption: [Bottom-up udfyldning af tabellen $r$.],
)

Med kun to løkker opnår vi nu en køretid på kun $O(n^2)$.

$r(n)$ giver os kun den bedste pris, og ikke hvilke stykker kæden skal deles op i (som var det opgaven bad om). For at få selve opdelingen gemmer vi også $s(n)$, som er længden af det sidste stykke, som gav den bedste værdi for $r(n)$. Hele udførslen af kæde-problemet kan ses:

#figure(
  image("figures/dpchaincomplete.png", width: 90%),
  caption: [Den fulde udregning: optimal værdi $r(n)$ og sidste længde $s(n)$ for hver $n$.],
)

Nu kan vi "spole tilbage" i den optimale løsning ved:

#figure(
  image("figures/dpplayback.png", width: 35%),
  caption: [Tilbagesporing via $s$: udskriv $s[n]$ og gå til $n - s[n]$.],
)

For f.eks. $n = 10$ printes løsningen: $(6, 2, 2)$.

=== Memoisering
Her kombinerer man rekursionens enkle struktur med tabellens effektivitet. Her benytter vi os af rekursiv kode, men gemmer svaret i en tabel første gang det beregnes. Næste gang samme delproblem efterspørges slår vi det blot op i stedet for at genberegne det.

#figure(
  image("figures/memoizationpseudo.png", width: 55%),
  caption: [`GULDKÆDE`: rekursiv (top-down) løsning der gemmer hvert resultat i $r$.],
)

Dette giver samme køretid på $O(n^2)$ og pladsforbrug $O(n)$. Dog måske en lidt dårligere konstant i praksis.


== Køretids- og pladsanalyse
_Noter tilføjes (aflæse kompleksitet ud fra en rekursionsligning; reducere pladsforbrug)._


== Eksamenstips og faldgruber
_Noter tilføjes._
