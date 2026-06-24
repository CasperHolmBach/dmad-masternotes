= Korteste veje
// Del B — Algoritmer og Datastrukturer · slides: shortestPathsSlides


== Vægtede grafer og korteste veje
Vægtede grafer har vægt på hver kant man kan følge. Derfor defineres længden af en sti som summen af vægte af kanterne på den sti.

$delta(s, v)$ = længden af en korteste sti fra $s$ til $v$. Sættes til $infinity$ hvis ingen sti findes.


== Single-source-problemet
Vælg én startknude $s$ og find $delta(s, v)$ til alle andre knuder $v$ plus en konkret vej.

#figure(
  image("figures/singlesourceproblem.png", width: 95%),
  caption: [Single-source korteste veje fra $s$ — træet af korteste veje.],
)

Man kommer dog i problemer, hvis man støder på en kreds der har en negativ sum. Her kan man blive ved med at følge kredsen rundt og gøre den totale længde kortere. Det gør spørgsmålet om "korteste længde" udefineret. Derfor vil vi gerne sørge for at der ikke findes negative kredse, så vi blot kan nøjes med at se på simple stier. Her er "længde af korteste sti" veldefineret.

#figure(
  image("figures/negativecycle.png", width: 75%),
  caption: [Knuder på (eller nedstrøms for) en negativ kreds får $delta = -infinity$.],
)


== Relaksering (relaxation)
"Relaxation" er en generel teknik til at finde den korteste vej. Idéen er at hver knude $v$ gemmer den bedste kendte stilængde fra $s$, kaldet $v.d$. Hvis vi så kender en sti med længden $u.d$ fra $s$, og der er en kant fra $u$ til $v$ med vægt $w(u, v)$, så kan vi sætte de to sammen og få en sti til $v$ af længde $u.d + w(u, v)$. Så er spørgsmålet: er det bedre end den bedste sti til $v$, vi allerede kender ($v.d$):
- Hvis ja: opdater $v.d = u.d + w(u, v)$ og sæt $v.pi = u$ (forgænger-pointer)
- Hvis nej: lad være, vi har ikke fundet noget nyt.

#figure(
  image("figures/relaxalgorithm.png", width: 40%),
  caption: [`RELAX(u, v, w)`: prøv at forbedre $v.d$ via kanten $(u, v)$.],
)

Det kan formuleres som: "Kan jeg lave en genvej til $v$ via $u$?"

De fleste efterfølgende algoritmer bygger ovenpå denne logik.

Relaxation har følgende invariant:
- Hvis $v.d < infinity$, så findes der faktisk en sti af den længde ($v.d$ er aldrig for optimistisk).

De knuder der har fået deres korrekte $d$-værdi, danner et træ med $pi$-pointers som forældre-pointers, og $s$ som rod.


== Dijkstras algoritme
En grådig algoritme, der bruger en prioritetskø ($Q$), som trinvis tager knuden med mindst $d$-værdi ud (`Extract-Min`), og lægger den i $S$, og så relax'er alle dens udgående kanter. Algoritmen kræver at alle kantvægte er $>= 0$.

#figure(
  image("figures/dijkstrapseudo.png", width: 60%),
  caption: [`DIJKSTRA`: greedy `Extract-Min` + relax af udgående kanter.],
)

#figure(
  image("figures/dijsktravisual.png", width: 95%),
  caption: [Dijkstra trin for trin; sorte knuder er færdigbehandlede (i $S$).],
)

Dijkstra har en køretid på $O((n + m) log n)$.


== Path-relaxation lemma
Hvis man relaxer kanterne langs en korteste vej, i den rigtige rækkefølge, så vil endeknuden få sin korrekte $delta$-værdi efter den sidste relax.


== Korteste veje i en DAG
I en DAG kan man topologisk sortere knuderne og relaxe kanterne i den orden. Så er man garanteret at have relaxed alle kanter på en korteste vej i rigtig rækkefølge.

#figure(
  image("figures/dagrelax.png", width: 65%),
  caption: [DAG: relax i topologisk orden — én gennemgang er nok.],
)

Køretid $O(n + m)$.


== Bellman-Ford
Relaxer alle kanter, gentaget $n - 1$ gange. Det er nok til at garantere, at enhver korteste vej er blevet fundet uanset hvilken rækkefølge kanterne kommer i. Bagefter checker man om der stadig kan relaxes noget: hvis ja er der en negativ kreds.

#figure(
  image("figures/bellmanfordpseudo.png", width: 50%),
  caption: [`BELLMAN-FORD`: $n - 1$ runder + kreds-check (`return FALSE`).],
)

#figure(
  image("figures/bellmanfordvisual.png", width: 80%),
  caption: [Bellman-Ford for en fast relaxeringsrækkefølge af alle kanter.],
)

Køretid $O(n m)$.


== All-pairs shortest paths
Nu vil vi finde korteste vej mellem alle par af knuder, ikke kun fra én startknude $s$.

Muligheder:
- Køre Dijkstra fra hver knude: $O(n (n + m) log n)$ — dog kun for ikke-negative kanter
- Køre Bellman-Ford fra hver knude: $O(n^2 m)$ — klarer negative kanter

Nye muligheder:
- Køre Floyd-Warshalls algoritme: $O(n^3)$ — klarer negative kanter
- Johnsons algoritme: $O(n^2 log n + n m)$ — klarer negative kanter

=== Floyd-Warshall-algoritmen
I stedet for at være baseret på Relax-metoden, benytter algoritmen dynamisk programmering. $d_(i j)^((k))$ gemmer korteste afstande, hvor man kun må gå via de første $k$ knuder som mellemstationer. Opdateringsformlen tjekker for hver $k$ om det er kortere at gå via $k$. Efter $n$ runder har man de sande korteste afstande.

#figure(
  image("figures/floydwarshall.png", width: 70%),
  caption: [`FLOYD-WARSHALL`: DP over tilladte mellemknuder $1, dots, k$.],
)

Køretid på $O(n^3)$ og pladsforbrug på $O(n^2)$.

=== Johnsons algoritme og re-weighting
Johnson kombinerer det bedste fra begge verdener: kør Bellman-Ford én gang for at finde "potentialer", brug dem til at omvægte alle kanter så de bliver ikke-negative, og kør derefter Dijkstra fra alle knuder.

Køretid på $O(n^2 log n + n m)$ og kan klare negative kanter.


== A\*-algoritmen
En version af Dijkstra der er "tunet" til at søge mod et specifikt mål $t$ fra startknude $s$. Her tilføjer man en heuristik $h(v)$, som er et gæt på afstanden fra $v$ til $t$. I stedet for at sortere prioritetskøen efter $v.d$ sorterer man efter $v.d + h(v)$, altså kendt afstand hertil plus gættet resterende afstand. På den måde søger algoritmen mere målrettet imod $t$ frem for at brede sig jævnt ud i alle retninger.

=== Konsistente heuristikker
En heuristik er konsistent, hvis den ikke er selvmodsigende langs kanter:

$ h(u) <= w(u, v) + h(v) $

Dvs. at heuristikkens gæt på korteste vej til $t$ for $u$'s naboer ikke er i modstrid med gættet på korteste vej til $t$ for $u$ selv.

A\* har samme worst case køretid som Dijkstra: $O((n + m) log n)$.


== Hvilken algoritme skal bruges
Valget afhænger af tre ting: (1) skal du finde korteste veje fra ÉN startknude
(single-source) eller mellem ALLE par af knuder (all-pairs)? (2) er der negative
kantvægte? (3) hvilken struktur har grafen (uvægtet / DAG / generel)?

=== Single-source (fra én startknude $s$)
#table(
  columns: 3,
  align: (left, left, left),
  table.header([Omstændighed], [Algoritme], [Køretid]),
  [Uvægtet graf (alle kanter koster det samme)], [BFS (se grafgennemløb)], $O(n + m)$,
  [DAG — også med negative vægte], [Relax i topologisk orden], $O(n + m)$,
  [Alle kantvægte $>= 0$], [Dijkstra], $O((n + m) log n)$,
  [Negative kanter (ingen negativ kreds)], [Bellman-Ford], $O(n m)$,
  [Søger kun mod ét mål $t$, har en heuristik], [A\*], $O((n + m) log n)$,
)

Vælg den hurtigste der passer til omstændighederne: er grafen en DAG, slår
topologisk relax altid Dijkstra; er alle vægte $>= 0$, er Dijkstra hurtigere end
Bellman-Ford; kun hvis der KAN være negative kanter, er Bellman-Ford nødvendig.

=== All-pairs (korteste vej mellem ALLE par af knuder)
#table(
  columns: 3,
  align: (left, left, left),
  table.header([Omstændighed], [Algoritme], [Køretid]),
  [Alle kantvægte $>= 0$], [Dijkstra fra hver knude], $O(n (n + m) log n)$,
  [Negative kanter, tæt graf ($m approx n^2$)], [Floyd-Warshall], $O(n^3)$,
  [Negative kanter, tynd graf ($m << n^2$)], [Johnson], $O(n^2 log n + n m)$,
  [Negative kanter, simpel kode], [Bellman-Ford fra hver knude], $O(n^2 m)$,
)

Tommelfingerregel for all-pairs med negative kanter: Floyd-Warshall ($O(n^3)$) er
enklest og bedst på tætte grafer; Johnson er bedre på tynde grafer, fordi
$O(n^2 log n + n m)$ slår $O(n^3)$ når $m$ er meget mindre end $n^2$.

=== Negative kredse: korteste vej er udefineret
Hvis der findes en negativ kreds, som kan nås på vejen mellem de relevante knuder,
er korteste vej IKKE veldefineret ($delta = -infinity$, fordi man kan gå kredsen
rundt i det uendelige). Kun *Bellman-Ford* (og Floyd-Warshall / Johnson, der bygger
på samme idé) kan DETEKTERE en negativ kreds — Dijkstra og DAG-metoden antager
stiltiende at problemet er veldefineret og giver forkerte svar ved negative
kredse.


== Eksamenstips og faldgruber

=== RELAX og Dijkstra — forklaret simpelt
*Hvad er RELAX overhovedet?* Tænk på $v.d$ som "det bedste jeg indtil nu ved om,
hvor langt der er fra start-knuden $a$ til $v$". I starten ved vi ingenting, så
alle andre knuder end $a$ har $v.d = infinity$ (uendelig langt væk, fordi vi ikke
har fundet en vej endnu).

RELAX på en kant $(u, v)$ stiller ét eneste simpelt spørgsmål: "Hvis jeg går til
$u$, og derfra videre til $v$ — er DEN vej kortere end den bedste vej til $v$, jeg
kendte i forvejen?" Konkret udregner $"RELAX"(u, v)$ værdien $u.d + w(u, v)$ og
sammenligner med $v.d$.
- *Hvis den nye vej er kortere* → vi opdaterer $v.d$ til den nye, mindre værdi. Det er det, opgaverne kalder "$v.d$ ændrer sig".
- *Hvis den nye vej ikke er bedre* (lige god eller værre) → vi gør ingenting; $v.d$ ændrer sig ikke.

*Eksempel.* Sig at $u.d = 5$ og kanten $(u, v)$ har vægt $3$. Den nye foreslåede
vej til $v$ er $5 + 3 = 8$.
- Hvis $v.d$ i forvejen var $infinity$ → $8 < infinity$, så vi opdaterer $v.d = 8$. #sym.checkmark Ændring.
- Hvis $v.d$ i forvejen allerede var $6$ → $8$ er ikke mindre end $6$, så vi gør ingenting. Ingen ændring.

Det er hele idéen — intet mere mystisk end det.

*Hvad gør Dijkstra så?* Dijkstra er bare en metode til at finde ud af, i hvilken
rækkefølge man skal RELAXe kanterne, så man garanteret finder de rigtige korteste
afstande. Opskriften er:
+ Sæt $a.d = 0$ (start-knuden), og alle andre knuders $d = infinity$.
+ Gentag indtil alle knuder er behandlet:
  - Find den knude der ikke er behandlet endnu, og som har den mindste $d$-værdi lige nu. Kald den $u$.
  - Markér $u$ som "behandlet" (den rører vi ikke igen).
  - Kør RELAX på alle kanter der går ud fra $u$ (altså $u$ → noget).

Man tager altid den nærmeste ubehandlede knude og "skubber" information videre fra
den til dens naboer.

*Hvordan tæller man, hvor mange RELAX der ændrer noget?* Lav en tabel — det er den
sikre metode der undgår fejl:

#table(
  columns: 4,
  align: (left, left, left, left),
  table.header([Knude vi behandler nu], [Kant vi relaxer], [Udregning], [Blev der ændret noget?]),
  [(den med mindste $d$)], [(en udgående kant fra den)], [gammel $d$ + vægt], [sammenlign med målets $d$],
)

Gå knude for knude, i den rækkefølge de bliver "behandlet" (mindste $d$ først), og
skriv hver enkelt udgående kant ned — selv de der virker "oplagte". Tæl til sidst,
hvor mange rækker der fik et #sym.checkmark.

*De typiske faldgruber:*
- *Forveksl ikke $v.d$ med "knuden der hedder $d$" i grafen.* Hvis grafen har en knude kaldet $d$, og opgaven taler om $v.d$, betyder det stadig "distance-værdien for en hvilken som helst knude $v$" — ikke "knuden $d$ specifikt". Det er bare et tilfælde at bogstavet er det samme.
- *Tjek pilenes retning meget omhyggeligt.* RELAX kan kun køres i den retning pilen peger. Hvis pilen går fra $e$ til $c$, kan man IKKE relaxe $c$ → $e$ — kun $e$ → $c$.
- *"Lige god" tæller ikke som ændring.* Det skal være strengt mindre ($<$), ikke "mindre end eller lig med" ($<=$), for at tælle som en ændring.
- *Skriv ALT ned i en tabel.* Det er nemt at "se" i hovedet at en kant ikke giver en ændring, og så glemme at tjekke den ordentligt — eller værre, glemme den helt. En systematisk tabel forhindrer den slags fejl.
