= Sortering
// Del B — Algoritmer og Datastrukturer · slides: sortingSlides, sortingInLinearTime

I en sorteringsalgoritme indgår der altid:
- *Input:* $n$ tal
- *Output:* De $n$ tal i sorteret orden

Vi vil gerne sortere vores data, da mange opgaver er hurtigere hvis de skal
lede blandt sorteret data. Tænk ordbøger, adresselister osv.

I dette kursus gennemgås følgende sorteringsalgoritmer:
- Insertionsort
- Selectionsort
- Bubblesort
- Mergesort
- Quicksort
- Heapsort
- Radixsort
- Countingsort

Sorteret rækkefølge i dette kursus er altid stigende.


== Sammenligningsbaserede sorteringer

=== Insertionsort
Ved insertionsort sørger man altid for at holde den venstre (gule) side af
arrayet sorteret, og man flytter så på skift det næste blå element ned på den
plads hvor den opfylder, at den gule del stadig er sorteret.

#figure(
  image("figures/insertionsortvisual.png", width: 75%),
  caption: [Insertionsort: den gule del holdes sorteret, og det næste blå element flyttes ind på sin plads.],
)

Insertionsort har en køretid på $O(n^2)$:

#figure(
  image("figures/insertionsortpseudo.png", width: 70%),
  caption: [Pseudokode for insertionsort.],
)


=== Selectionsort
Ved selectionsort holder man input i en liste for sig selv, og så flytter man i
hver iteration det mindste element over i en outputliste.

Selectionsort har en køretid på $O(n^2)$.

#figure(
  image("figures/selectionsortpseudo.png", width: 70%),
  caption: [Pseudokode for selectionsort.],
)


=== Mergesort
En sorteringsalgoritme der bruger divide and conquer konceptet. Mergesort deler
et givent usorteret input op indtil den står tilbage med lister kun af længden
én. En liste på længden én må jo være sorteret, så derfor kan vi nøjes med kun
at kigge på det første element for at finde den laveste værdi. Nu kan vi begynde
at flette alle listerne sammen ved at vælge den laveste værdi fra hver liste.

#figure(
  image("figures/megesortvisual.png", width: 75%),
  caption: [Mergesort: input deles ned til lister af længde én og flettes derefter sammen.],
)

Mergesort har en køretid på $O(n log n)$. Det skyldes at det ikke koster noget i
arbejde at splitte listen ud (trivielt arbejde). Eftersom vi halverer $n$ i hver
iteration får vi en rekursionsdybde på $log(n)$. Når vi fletter elementer,
kigger vi kun listen igennem én gang, og derfor laver vi kun $n$ arbejde per lag.


=== Quicksort
Har samme grundstruktur som mergesort (del op $arrow.r$ rekursion $arrow.r$ sæt
sammen). Dog lægger alt arbejdet i opdelingen (partitioneringen).

Til at starte med vælges der et pivotpoint, hvorfra alle andre elementer
sammenlignes med. Alle elementer mindre end pivot ryger i listen $X$ og alle
elementer større end pivot ryger i listen $Y$. Denne proces bliver kaldt
rekursivt for henholdsvis $Y$ og $X$, indtil listen til sidst er sorteret.

*Best case / average case:* Hvis pivotpointet deler listen fair op i midten får
vi $log(n)$ lag og derfor en køretid på $O(n log n)$.

*Worst case:* Dog hvis pivotpointet er dårligt valgt får man et skævt træ,
hvilket resulterer i en køretid på $O(n^2)$.

Det er dumt at vælge det sidste indekserede element som pivotpoint, ligesom der
gøres i eksemplet. Det skyldes to årsager:
- Nogen kan påtvinge worst case scenarie hvis de kan lære hvilket pivotpoint du har valgt.
- Ofte behandler vi data, som er næsten sorteret, hvilket ofte vil resultere i at den højeste, eller en af de højeste, værdier vil optræde i sidste indeks. Dette giver et skævt træ og dermed $O(n^2)$.


=== Heapsort
En Heap er:
- Et binært træ
- Med heap-orden
- Og heap-facon
- Udlagt i et array

==== 1) Binært træ
Et binært træ kan enten være et tomt træ, eller en knude $v$ samt to undertræer:

#figure(
  image("figures/binarytree.png", width: 55%),
  caption: [Et binært træ: en rod med to undertræer.],
)

Knuden $v$ kaldes også rod for træet. Hvis $v$ har et ikke tomt undertræ
(venstre eller højre), så har de(t) undertræer sin egen rod, som kaldes $u$.
- $u$ er et barn af $v$
- $v$ er forælder til $u$

Hvis begge $v$'s undertræer er tomme, kaldes $v$ et blad. Stregerne mellem børn
og forældre kaldes for kanter.

#figure(
  image("figures/binarytreeinfo.png", width: 60%),
  caption: [Terminologi for et binært træ: rod, barn, forælder, blad og kanter.],
)

==== 2) Heap-orden
Et binært træ med værdier i alle knuder er max-heap-ordnet hvis det for enhver
knude $v$ med barn $u$ gælder at:
$ "værdi i " v >= "værdi i " u $
Det vil sige at træet er opbygget fra højeste værdi og så faldende ned igennem
træet:

#figure(
  image("figures/maxheaporder.png", width: 55%),
  caption: [Max-heap-orden: enhver forælder er større end eller lig sine børn.],
)

Det omvendte ville være min-heap-orden, hvor:
$ "værdi i " v <= "værdi i " u $
Det vil sige at træet er opbygget fra laveste værdi og så stigende ned igennem træet.

==== 3) Heap-facon
Et binært træ har heap-facon hvis alle lag i træet er helt fyldte, undtagen det
sidste lag, hvor alle knuder findes længst til venstre:

#figure(
  image("figures/heapshape.png", width: 55%),
  caption: [Heap-facon: alle lag fyldte, sidste lag fyldt fra venstre.],
)

==== 4) Heap udlagt i et array
Har man et binært træ der overholder heap-facon, kan man udlægge det i et array,
ved at tildele array-indekser til knuder ved et top-down, venstre-til-højre
gennemløb (BFS) af træets lag.

#figure(
  image("figures/heapinarray.png", width: 70%),
  caption: [En heap udlagt i et array via et lagvist BFS-gennemløb.],
)

Når vi har lagt et heap i et array kan vi nemt navigere mellem forældre og børn
knuder. Knuden på plads $i$ har:
- Sin forælder på plads $i/2$
- Sine børn på plads $2i$ og $2i+1$

==== Operationer på en heap
Vi bruger generelt følgende operationer på en heap:
- *Max-Heapify:* Givet en knude med to undertræer, som hver især overholder heap-orden, få hele knudens undertræ til at overholde heap-orden.
- *Build-Max-Heap:* Lav $n$ uordnede input elementer til en heap.

*Max-Heapify:*
Det er et problem hvis en knudes værdi er mindre end ét eller begge børns værdier
(i en max heap). For at løse det bruger vi max-heapify, hvor knuden bytter plads
med barnet der har den største værdi. Det kan vi nu gøre igen på den samme knude
der nu er rykket et lag ned, og vi bliver ved indtil træet opfylder
max-heap-orden.

#figure(
  image("figures/maxheapify.png", width: 70%),
  caption: [Max-Heapify lader knuden synke ned ved at bytte med det største barn.],
)

Har en køretid på $O("højde af knude")$.

*Build-Heap:*
Den "globale" funktion, der går igennem træet startende fra den sidste
ikke-blad-knude og bevæger sig så baglæns op igennem træet. For hver knude i
rækkefølgen kalder den så Max-Heapify. Her er Max-Heapify så den lokale funktion
der faktisk udfører arbejdet.

#figure(
  image("figures/buildheap.png", width: 70%),
  caption: [Build-Heap kalder Max-Heapify baglæns fra sidste ikke-blad-knude.],
)

Har en køretid på $O(n)$.

*Heapsort:*
En form for selectionsort hvor der bruges en heap til hele tiden at udtage det
største tilbageværende element:

#figure(
  image("figures/heapsortpseudo.png", width: 70%),
  caption: [Pseudokode for heapsort.],
)

Det kan også ses visuelt:

#figure(
  image("figures/heapsortvisual.png", width: 75%),
  caption: [Heapsort: gentagen udtagning af det største element fra heapen.],
)

Heapsort har en køretid på $O(n log n)$.

De tre $O(n log n)$ sorteringsalgoritmer:

#figure(
  image("figures/threesortingalgorithms.png", width: 55%),
  caption: [Quicksort, mergesort og heapsort sammenlignet på worst case og in-place.],
)


== Lineærtids-sorteringer
Sammenligningsbaserede sorteringsalgoritmer har alle sammen de følgende egenskaber:
- *Basal handling:* sammenlign to elementer i input og foretag derudfra et valg mellem to måder at fortsætte på
- *Svar:* den opstilling som skal laves for at få sorteret orden
- *Id for elementer:* deres oprindelige position (index) i input.

På baggrund af disse egenskaber kan vi opstille et decision tree som er generelt
for alle sammenligningsbaserede sorteringsalgoritmer:

#figure(
  image("figures/allcomparingsortingalgorithms.png", width: 70%),
  caption: [Decision tree for en sammenligningsbaseret sortering af tre elementer.],
)

For at nå til svaret: det komplet sorteret output, bliver vi altså altid nødt til
at bevæge os mindst $log(n!)$ lag ned i dette decision tree, hvilket asymptotisk
er $Omega(n log n)$.

For at kunne sortere hurtigere end $Omega(n log n)$ bliver vi altså nødt til at
bevæge os væk fra sammenligningsalgoritmer.

=== Counting sort
Bruger alle elementer fra input som array-indekser. Det kræver dog at input kun
er fyldt med heltal, af størrelse op til $k$ (den højeste værdi blandt input).
Counting sort benytter tre array's $A$, $B$ og $C$.
- $A$ – input array med længde $n$
- $C$ – et "tæller-array" med længde $k+1$, ét felt for hver mulig værdi $(0, 1, ..., k)$
- $B$ – output arrayet, hvor det sorterede resultat ender, med længde $n$

Først går algoritmen $A$ igennem, og tæller op i $C$ for hvert element på den
plads der svarer til elementets værdi. F.eks. hvis $A$ indeholder 3 to gange vil
$C[3] = 2$.

#figure(
  image("figures/countingsorta.png", width: 50%),
  caption: [Input-arrayet $A$.],
)

Nu står vi med $C$, som kan se således ud:

#figure(
  image("figures/countingsortc.png", width: 40%),
  caption: [$C$ efter optælling: antallet af hver værdi.],
)

Nu ved vi hvor mange elementer der er af hver værdi, men vi ved endnu ikke
hvilken position i $B$ hvert element skal have. Næste fase handler om at omdanne
$C$ så hver celle i stedet fortæller "hvor mange elementer i alt er $<=$ denne
værdi." Det gøres med:
$ C[i] = C[i] + C[i-1] $
Nu kommer $C$ til at se sådan ud:

#figure(
  image("figures/countingsortc2.png", width: 40%),
  caption: [$C$ efter præfikssummering: antal elementer $<=$ hver værdi.],
)

I sidste fase gennemgår vi $A$ baglæns, og for hvert element bruger vi $C$ til at
finde dens korrekte plads i det sorterede array $B$.

Vi starter altså med at kigge på indeks $A[8]$, som indeholder værdien 3. Så
kigger vi i array $C$, hvor 3 skal placeres: $C[3] = 7$, altså værdien 3 skal
placeres på array $B$'s 7. indeks. Efter at have placeret 3 skal værdien gemt i
$C[3]$ nu dekrementeres med 1, så den er klar i tilfældet af at vi opdager endnu
en 3'er i $A$. Nu fortsættes hele denne proces og vi tager nu $A[7]$, osv osv…

#figure(
  image("figures/countingsortvisual.png", width: 90%),
  caption: [Counting sort trin for trin: placering af elementer i $B$ via $C$.],
)

Counting sort har køretiden $O(n + k)$.

=== Radix sort
Endnu en ikke-sammenligningsbaseret sorteringsalgoritme, der også kan sortere i
lineær tid. Radix sort sorterer tal cifferposition for cifferposition, startende
fra det mindst betydende ciffer (længst til højre) og bevæger os mod det mest
betydende (længst til venstre).

Vi starter altså med kun at sortere enerne. Derefter sorterer vi kun tiere. Til
sidst sorterer vi kun hundrede.

#figure(
  image("figures/radixsortvisual.png", width: 80%),
  caption: [Radix sort: stabil sortering på ét ciffer ad gangen, fra højre mod venstre.],
)

Radix sort har en køretid på $O(d (n + k))$, hvis der bruges counting sort i
for-løkken.


== Sammenligningstabel
_Noter tilføjes (bedste/gennemsnitlige/værste tilfælde, in-place, stabil)._


== Eksamenstips og faldgruber
_Noter tilføjes._
