= Grafgennemløb
// Del B — Algoritmer og Datastrukturer · slides: graphTraversalSlides, connectedComponentsSlides


== Grafer
Grafer indeholder en mængde af knuder $V$ (vertices). Grafer indeholder også en
mængde af kanter $E$ mellem knuder.

Standard notation for mængden af knuder og kanter:
- $n$ = antal knuder
- $m$ = antal kanter

*(a) Orienterede grafer*
- Her er kanterne ordnede par. Det vil sige at forbindelserne ($E$) er pile der
  viser en retning.
- Det gælder at: $0 <= m <= n^2$

*(b) Uorienterede grafer*
- Her er kanterne uordnede par. Det vil sige forbindelserne ($E$) ikke viser
  nogen retning.
- Det gælder at: $0 <= m <= n^2/2 + n/2$

#figure(
  image("figures/graphtypes.png", width: 70%),
  caption: [Orienterede og uorienterede grafer.],
)

Grafer kan bruges til at modellere mange forskellige ting:
- Ledningsnet
- Vejnet
- Venner på SoMe

Blandt meget mere…


== Datastrukturer for grafer
Adjacency lists og adjacency matrix er begge datastrukturer der bruges til at
gemme grafer på computeren.

#figure(
  image("figures/graphdatastructures.png", width: 80%),
  caption: [Samme graf vist på tre måder.],
)

Figuren viser den samme graf visualiseret på forskellige måder:
- (a) er den visuelle / grafiske repræsentation
- (b) er en adjacency list repræsentation
- (c) er en adjacency matrix repræsentation

List- og matrixstrukturerne har forskellig mængde pladsforbrug. Adjacency lists
har et pladsforbrug på $O(n + m)$, hvorimod adjacency matricer har et
pladsforbrug på $O(n^2)$.

Det betyder, at adjacency lists er mere pladseffektive, når grafen er ”sparse”
(har få kanter $m$), mens adjacency matrix kan være praktiske når grafen er
”dense” (mange kanter $m$). Matrixens pladsforbrug afhænger nemlig slet ikke af
mængden af kanter $m$ og betaler derfor ikke ekstra for at have de ekstra
kanter. Desuden har matrixen $O(1)$ opslagstid, og er derfor foretrukken til en
dense graf.

I dette kursus er adjacency lists standarden, og er også mest brugt i praksis.


== Grafgennemløb
En algoritme-type der bruges til systematisk at besøge knuderne i en graf,
typisk for at finde ud af hvilke knuder der kan nås fra et givet startpunkt.

*Opgave:* Givet en graf i adjacency lists repræsentation, besøg alle knuder og
kanter. Målet er at undersøge forskellige egenskaber for grafen.

*Generel idé:* Besøg en startknude $s$. Brug derefter kanter i nabolisterne for
besøgte knuder til at besøge flere knuder.

Knuder bliver markeret undervejs for at holde styr på processen:
- *Hvide knuder:* ikke besøgt endnu
- *Grå knuder:* besøgt, men ikke alle kanter i naboliste brugt
- *Sorte knuder:* besøgt, alle kanter i naboliste brugt

Pseudokoden for sådan en algoritme kunne se således ud:

#figure(
  image("figures/graphtraversalpseudo.png", width: 65%),
  caption: [Pseudokode for et generelt grafgennemløb.],
)

Algoritmen vil nå alle de punkter som er forbundet til startknuden $s$. Hvis vi
desuden vil garantere at besøge alle knuder i en graf der er opbrudt (alle
knuder er ikke forbundet) kan vi lave følgende wrapper:

#figure(
  image("figures/globalgraphtraversalpseudo.png", width: 65%),
  caption: [Global wrapper der besøger alle knuder i en opbrudt graf.],
)

Her sørger vi for at vælge en ny startknude, hvis grafgennemløbet blev
færdiggjort, men der stadig findes hvide knuder. Med den globale wrapper kan vi
nu claim:

#figure(
  image("figures/globalgraphtraversalclaim.png", width: 75%),
  caption: [Claim for det globale grafgennemløb.],
)

Man kan med fordel gemme hvem der besøgte en given knude $u$ for første gang
(også kaldet $u$'s predecessor) i variablen $pi$. Dette giver mulighed for
senere at bygge et træ der viser den omvendte retning, af grafgennemløbet.
Følger man den baglæns rækkefølge vil man uundgåeligt også ende med at finde
tilbage til startknuden $s$.

$u.pi$ sættes kun én gang, nemlig første gang. Her er den nemlig stadig hvid, og
efter $pi$ er sat bliver den nu grå. Derfor kan variablen ikke blive sat igen.
Samtidig bliver denne variabel instantieret, som NIL én gang i starten.

Kurset dækker tre forskellige strategier af bevæge sig gennem en graf på:
- Breadth-First-Search (BFS)
- Depth-First-Search (DFS)
- Priority-Search (Dijkstras algoritme, A\*)


== Bredde-først søgning (BFS)
Strategien for bredde først søgning er at holde de grå knuder i en kø (queue),
og så bruger vi nabolisterne op med det samme. Derudover tilføjer vi også en
variabel $v.d$ til alle knuder $v$ ($d$ for distance). Invarianten for BFS er at
køen altid indeholder alle grå knuder.

#figure(
  image("figures/bfspseudo.png", width: 65%),
  caption: [Pseudokode for BFS.],
)

BFS har en køretid på $O(n + m)$.

Vi kan definere: $delta(s, v)$, som længden af den korteste sti (målt i antal
kanter), fra startknuden $s$ til knuden $v$.

*Sætning:* Når BFS stopper, gælder $v.d = delta(s, v)$.

Det betyder også: For hver knude $v$ i grafen gælder: når BFS er færdig, er den
værdi, der står gemt i $v$'s eget d-felt, lig med den korteste afstand fra $s$
til netop denne $v$.

*Observationer for BFS:*

#figure(
  image("figures/bfsobservations.png", width: 80%),
  caption: [Observationer for BFS.],
)

=== Induktionsbevis for BFS
Vi vil bevise: for alle knuder $v$, gælder $v.d = delta(s, v)$, når BFS er
færdig. Altså: den værdi BFS regner sig frem til $v.d$ er præcis den rigtige
korteste afstand $delta(s, v)$. Ikke for stor og ikke for lille.

*Basistilfælde:* $i = 0$

Hvis $delta(s, v) = 0$, betyder det, at den korteste sti fra $s$ til $v$ har 0
kanter. Det vil sige $v$ er $s$ (BFS står stadig på startknuden). Her sætter BFS
altså $s.d = 0$. Så for $v = s$ er $v.d = 0 = delta(s, v)$. Dermed er
basistilfældet vist.

*Induktionsskridt:* $i > 0$

Nu bevæger vi os et skridt frem ($i$++). Vi ved at det gælder for
basistilfældet som nu er $i - 1$, og skal nu bevise det også gælder for det nye
$i$. Vi siger at $v$ har $delta(s, v) = i$. Det betyder, der findes en korteste
sti fra $s$ til $v$ med $i$ kanter:
$ s arrow.r ... arrow.r u arrow.r v $
Fordi stien fra $s$ til $v$ gennem $u$ har $i$ kanter i alt, og den sidste kant
er $(u, v)$, har $u$ altså afstanden $i - 1$, og dermed også $i - 1$ kanter. Det
må desuden også være den korteste vej til $u$ for hvis der var en kortere vej
til $u$, med f.eks. $i - 2$ kanter, kunne man forlænge den med kanten $(u, v)$
og få en sti til $v$ med $i - 1$ kanter i alt. Det ville modsige at $v$'s
korteste vej var $i$ (vi ville have fundet den samme kortere vej ellers),
hvilket er en modstrid til udgangspunktet / antagelsen. Så $delta(s, u) = i - 1$.

Når BFS tager $u$ ud af køen kigger den på alle naboerne, inklusiv $v$. I BFS
tildeles $v$ en d-værdi, som er én større end d-værdien af knuden, som opdager
den. Derfor $v.d = u.d + 1$, hvis $v$ var hvid. Hvis $v$ allerede er opdaget af
en anden knude $t$ så bliver $v.d = t.d + 1$. Eftersom BFS har en FIFO-kø, må
$t$ være taget ud af køen før $u$, og da d-værdier stiger monotont gennem køen
(observation 1), gælder derfor $t.d <= u.d = i - 1$. Begge tilfælde resulterer i
$v.d <= i$.

Vi ved desuden pga. observation 2, at $delta(s, v) <= v.d$ altid gælder
generelt. Det giver os $v.d >= i$ da $delta(s, v) = i$. Det resulterer til sidst
i:
$ v.d = i = delta(s, v) $


== Dybde-først søgning (DFS)
Strategien for DFS er at holde alle de grå knuder i en stak (stack). Dermed
avancerer vi minimalt i nabolisten hver gang vi kigger på en knude. Desuden
tilføjer DFS også et timestamp $u.d$ for discovery (hvid $arrow.r$ grå). Meget
vigtigt at huske $u.d$ ikke er distance, som det var ved BFS.

#figure(
  image("figures/dfspseudo.png", width: 70%),
  caption: [Pseudokode for DFS.],
)

DFS har en køretid på $O(n + m)$.

*(Discovery)* Når en knude går fra hvid til grå:
- $v.d$ sættes
- DFS-visit kaldes på $v$
- $v$ lægges på stakken (PUSH)

*(Finish)* Når en knude går fra grå til sort:
- $v.f$ sættes (finish time)
- Der returneres fra kaldet til DFS-visit på $v$
- $v$ tages af stakken (POP)

Værdien $v.pi$ (predecessor / parent) bliver sat når DFS-visit bliver kaldt på
$v$. Det er skyld i følgende tre ting:
- Kanterne $(v.pi, v)$ udgør rekursionstræerne – hver gang DFS-Visit kalder sig
  selv rekursivt opretter den en ”parent-child” relation i et træ.
- Intervallet $[v.d, v.f]$ er den periode, $v$ er på stakken.
- $v$ er grå hvis og kun hvis den er på stakken.

Når man undersøger en kant $(u, v)$ fra $u$ kan man kvalificere kanter i fire
type, baseret på hvad man kan observere om farven af knuden $v$:
- *Tree-kanter* – $v$ er hvid, altså $v$ er ikke blevet besøgt før. ”Normale
  situation”.
- *Back-kanter* – $v$ er grå, altså $v$ ligger allerede på stakken.
- *Forward-kanter* – $v$ er sort, altså $v$ er allerede færdigbehandlet, men har
  engang været på stakken samtidig med $u$.
- *Cross-kanter* – $v$ er sort, altså $v$ er allerede færdigbehandlet. Den er
  ikke længere på stakken og har ikke været det sammen med $u$.

For uorienterede grafer er der kun tree-kanter og back-kanter.

#figure(
  image("figures/edgecases.png", width: 80%),
  caption: [De fire kanttyper under DFS.],
)

Discovery og finish times på tværs af to knuder kan beskrives som:
+ $u.d <= v.d < v.f <= u.f$ — De er nestet
+ $u.d < u.f < v.d < v.f$ — De er disjunkte

#figure(
  image("figures/timenesting.png", width: 55%),
  caption: [Nestede vs. disjunkte tidsintervaller.],
)

=== Hvid-sti lemma
*Hvid sti lemma:* Hvis der findes en sti af hvide knuder (inklusiv $w$), fra $u$
til $w$ til tid $u.d$, da gælder $u.d < w.d < w.f < u.f$.

*Bevis:*

Vi har kæden: $u arrow.r a arrow.r b arrow.r w$ og alle fire knuder er hvide, da
DFS opdager $u$ (sætter her tiden $u.d$). Eftersom hele stien er hvid ved vi:
$u.d <= a.d, space u.d <= b.d, space u.d <= w.d$. Ingen af dem er opdaget endnu
så deres discovery time må være efter $u$'s. Vi ved fra regler om discovery og
finish times at det kun er muligt at én af sætningerne er aktuelle ad gangen.

Nu antager vi at det går galt ved knuden $b$: tidsintervallet ikke er nestet
inde under $u$'s interval. Eftersom $b$ er den første knude det går galt ved, må
knuden før, altså $a$, stadig være nestet pænt ind under $u$. Dog, eftersom
kanten $(a, b)$ eksisterer, må det betyde at $a.d <= b.d$. Desuden opdages $b$
(og dermed $b.d$) imens $a$ er grå og $b$ stadig er hvid. Det vil desuden sige
at $b.d < a.f$. Derfor, ville det skabe en modstrid hvis knuden $b$ ikke skulle
opfylde sætning 1, da vi ved begge dele ikke er muligt samtidig.


== DAG (Directed Acyclic Graph) og topologisk sortering
En DAG er en orienteret graf uden kredse (cycles). Man kan altså ikke starte ved
en knude, følge kanternes retning rundt, og ende tilbage ved samme knude. De
bruges ofte til at modellere afhængigheder:

#figure(
  image("figures/dag.png", width: 65%),
  caption: [En DAG der modellerer afhængigheder, med discovery-/finish-tider.],
)

Med topologisk sortering kan man give en DAG en lineær ordning af knuderne så
alle kanter går fra venstre til højre:

#figure(
  image("figures/dag2.png", width: 95%),
  caption: [Topologisk sortering: knuderne ordnet lineært.],
)

*Lemma:* En orienteret graf har en kreds (cycle) $arrow.l.r.double$ der findes
back-edges under et DFS-gennemløb.

*Bevis:*

$arrow.r.double$: Vi ser på den første knude $v$ i kredsen, som DFS gør grå.
Fordi $v$ er den første, må alle de andre knuder i kredsen stadig være hvide på
tidspunktet $v.d$. Det betyder at resten af kredsen hele vejen rundt og tilbage
til $v$, er en hvid sti. Her bruger vi hvid-sti lemmaet: hvis $u$ er den sidste
knude i kredsen (den der peger tilbage på $v$), så garanterer hvid-sti lemmaet:
$v.d < u.d < u.f < v.f$. Det betyder når DFS undersøger kanten $(u, v)$ er $v$
stadig grå, hvilket er definitionen af en back-kant.

$arrow.l.double$: En back-kant $(u, v)$ betyder at $v$ er grå, altså $v$ stadig
er på stakken, et sted over $u$. Det betyder der findes en kæde af tree-kanter
fra $v$ ned til $u$ (det er sådan $u$ kom til at ligge under $v$ på stakken). Nu
lægges back-kanten $(u, v)$ blot til og så har man en kreds:
$v arrow.r ... arrow.r u arrow.r v$.

*Lemma:* For en kant $(u, v)$ gælder $u.f <= v.f arrow.l.r.double$ kanten er en
back-kant.

*Bevis:* Check tidligere note om ordning af $u.f$ og $v.f$ for de fire
forskellige kantcases. Det er kun back-kant der matcher $u.f <= v.f$.

*Korollar til to foregående lemmaer:* Graf er en DAG $arrow.l.r.double$ DFS
finder ingen back-kanter $arrow.l.r.double$ ordning af knuder efter faldende
finish-tider giver en topologisk sortering.

Følgende algoritme finder en topologisk sortering i en DAG:

#figure(
  image("figures/topologicalsort.png", width: 75%),
  caption: [Pseudokode for `TOPOLOGICAL-SORT`.],
)

Algoritmen har en køretid på $O(n + m)$.


== Sammenhængskomponenter (CC) — uorienterede grafer
For uorienterede grafer defineres: $u tilde.op v$ hvis der findes en uorienteret
sti mellem dem. Her er en uorienteret graf med en partition af størrelse tre:

#figure(
  image("figures/threepartitions.png", width: 45%),
  caption: [Uorienteret graf med tre sammenhængskomponenter.],
)

Partitionerne kaldes sammenhængskomponenter (CC'er).

Vi finder CC'er ved at køre DFS eller BFS med et globalt ydre loop, så vi sørger
for at finde alle mulige startknuder. Tidskompleksiteten er $O(n + m)$.

Det at finde sammenhængskomponenter kan bruges til f.eks.:
- Vurdere om et elektrisk netværk er forbundet, så strøm kan nå alle vegne rundt
- Finde regioner i billeder med en bestemt type farve (f.eks. magic wand tool i
  Photoshop)
- Analysere sociale netværk

=== Stærke sammenhængskomponenter (SCC) — orienterede grafer
For orienterede grafer defineres: $u tilde.op v$ hvis der findes en orienteret
sti fra $u$ til $v$, OG fra $v$ til $u$. Her er en orienteret graf med en
partition af størrelse fire:

#figure(
  image("figures/fourpartitions.png", width: 70%),
  caption: [Orienteret graf med fire stærke sammenhængskomponenter.],
)

Disse partitioner kaldes stærke sammenhængskomponenter (SCC'er).

Vi finder SCC'er ved at benytte Kosarajus algoritme:

#figure(
  image("figures/kosarajus.png", width: 80%),
  caption: [Pseudokode for Kosarajus algoritme (`SCC`).],
)

Algoritmen starter med at bruge DFS på grafen $G$, og beregner finishtiden $u.f$
for hver knude på grafen.

Nu konstrueres $G^T$, altså den transponerede graf, dvs. samme graf, men med
alle kanter vendt om. F.eks. $(x, y)$ i $G$ bliver til $(y, x)$ i $G^T$.

Nu bruges DFS så på den transponerede graf $G^T$. Dog her, i det globale loop,
skal man besøge knuderne i faldende rækkefølge af deres finishtid udregnet i
step 1. Det vil sige man starter med den knude der blev færdigbehandlet sidst i
første DFS.

Hvert træ der dannes af DFS($G^T$) er præcis én SCC.

Algoritmen har en køretid på $O(n + m)$.


== Eksamenstips og faldgruber

=== Topologisk sortering: tjek en kandidatliste
*Definition.* En topologisk sortering af en rettet acyklisk graf (DAG) er en
rækkefølge af ALLE knuder, sådan at for HVER kant $u -> v$ i grafen, kommer $u$
FØR $v$ i rækkefølgen. Der findes typisk FLERE gyldige topologiske sorteringer
for samme graf — det er ikke nødvendigvis kun ét rigtigt svar.

*VIGTIG MISFORSTÅELSE.* Det er IKKE et krav at nabopar i listen har en direkte
kant mellem sig. Hvis listen er $x, y, z, dots$ er det IKKE et krav at $x -> y$ og
$y -> z$ er kanter i grafen. Der kan godt stå andre knuder imellem to knuder der
har en kant. Det eneste krav er: for HVER eksisterende kant $u -> v$ i grafen
(uanset hvor langt fra hinanden $u$ og $v$ står i listen), skal $u$ stå ET STED
FØR $v$.

*Metoden til at TJEKKE en given kandidatliste (hurtigst):* I stedet for at
konstruere en sortering fra bunden, er det hurtigere at verificere en given
kandidatliste direkte:
+ List ALLE kanter i grafen ($u -> v$).
+ For hver kandidatliste: find positionen (indekset) af hver knude i listen.
+ For hver kant $u -> v$: tjek om $"pos"(u) < "pos"(v)$ i kandidatlisten.
  - Hvis JA for alle kanter → listen ER en gyldig topologisk sortering.
  - Hvis NEJ for bare ÉN kant (altså $v$ står før $u$, selvom kanten er $u -> v$) → listen er UGYLDIG, forkast den.

*Eksempel.* Graf med kanter: $b -> a$, $b -> c$, $b -> d$, $b -> e$, $d -> a$, $d -> e$, $c -> e$, $f -> c$, $f -> e$.

Tjek kandidatlisten: $f, b, d, c, a, e$.
- $b -> a$: $"pos"(b) = 2$, $"pos"(a) = 5$ → $2 < 5$ #sym.checkmark
- $b -> c$: $"pos"(b) = 2$, $"pos"(c) = 4$ → $2 < 4$ #sym.checkmark
- $b -> d$: $"pos"(b) = 2$, $"pos"(d) = 3$ → $2 < 3$ #sym.checkmark
- $b -> e$: $"pos"(b) = 2$, $"pos"(e) = 6$ → $2 < 6$ #sym.checkmark
- $d -> a$: $"pos"(d) = 3$, $"pos"(a) = 5$ → $3 < 5$ #sym.checkmark
- $d -> e$: $"pos"(d) = 3$, $"pos"(e) = 6$ → $3 < 6$ #sym.checkmark
- $c -> e$: $"pos"(c) = 4$, $"pos"(e) = 6$ → $4 < 6$ #sym.checkmark
- $f -> c$: $"pos"(f) = 1$, $"pos"(c) = 4$ → $1 < 4$ #sym.checkmark
- $f -> e$: $"pos"(f) = 1$, $"pos"(e) = 6$ → $1 < 6$ #sym.checkmark

Alle betingelser holder → GYLDIG topologisk sortering.

Modeksempel: listen $d, b, c, a, f, e$ ville være UGYLDIG, fordi $b -> d$ kræver
at $b$ står før $d$, men her står $d$ (pos 1) før $b$ (pos 2).

*Praktiske genveje til at spotte ugyldige lister hurtigt:*
- Knuder med 0 indgående kanter (rene "kilder", som $b$ i eksemplet) skal altid stå tidligt — de kan aldrig have nogen der peger på dem som skal stå før dem.
- Knuder med 0 udgående kanter (rene "synke", som $e$ i eksemplet) skal altid stå sent — de peger ikke selv på nogen, men mange peger på dem.
- Tjek disse "kilde"- og "synke"-knuder FØRST i en kandidatliste — det udelukker ofte forkerte svar hurtigt, før man skal tjekke alle kanter.

*Konstruér selv en sortering (Kahns algoritme):*
+ Find en knude med 0 indgående kanter (fra de resterende knuder).
+ Tilføj den til rækkefølgen.
+ Fjern knuden og alle dens udgående kanter fra grafen.
+ Gentag indtil alle knuder er placeret.

Hvis der på et tidspunkt ikke findes nogen knude med 0 indgående kanter, men der
stadig er knuder tilbage, indeholder grafen en cyklus, og der findes IKKE en
topologisk sortering.
