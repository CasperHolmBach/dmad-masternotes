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
_Noter tilføjes (counting sort, radix sort, bucket sort)._


== Sammenligningstabel
_Noter tilføjes (bedste/gennemsnitlige/værste tilfælde, in-place, stabil)._


== Eksamenstips og faldgruber
_Noter tilføjes._
