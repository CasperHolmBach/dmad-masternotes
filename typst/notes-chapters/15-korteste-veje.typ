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
_Noter tilføjes (valg ud fra negative kanter / cykler / DAG)._


== Eksamenstips og faldgruber
_Noter tilføjes._
