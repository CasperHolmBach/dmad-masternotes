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

*Bedste og værste tilfælde:* Insertionsort er adaptiv — køretiden afhænger af
inputtets orden.
- *Bedste tilfælde* ($O(n)$): inputtet er allerede sorteret (stigende). Hvert nyt element sammenlignes kun én gang med sin venstre nabo og flyttes ikke.
- *Værste tilfælde* ($O(n^2)$): inputtet er omvendt sorteret (faldende). Hvert nyt element skal forskydes hele vejen forrest i den sorterede del.


=== Selectionsort
Ved selectionsort holder man input i en liste for sig selv, og så flytter man i
hver iteration det mindste element over i en outputliste.

Selectionsort har en køretid på $O(n^2)$.

#figure(
  image("figures/selectionsortpseudo.png", width: 70%),
  caption: [Pseudokode for selectionsort.],
)

*Bedste og værste tilfælde:* $O(n^2)$ i ALLE tilfælde, uafhængigt af inputtets
orden. Algoritmen skanner altid hele den usorterede rest igennem for at finde det
mindste element — også selvom inputtet allerede er sorteret. Der er derfor ingen
gevinst ved et "pænt" input.


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

*Bedste og værste tilfælde:* $O(n log n)$ i alle tilfælde. Opdelingen og
fletningen udføres ens uanset inputtets orden, så bedste og værste tilfælde er
asymptotisk det samme.


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

*Bedste og værste tilfælde:* $O(n log n)$ for vilkårlige (forskellige) inputs,
uafhængigt af inputtets orden. Build-Heap koster $O(n)$, og derefter udtages $n$
elementer, hver med et Max-Heapify-kald på $O(log n)$. (Specialtilfælde: ved mange
identiske elementer kan sift-down stoppe straks, så køretiden falder til $O(n)$ —
se eksamenstippet sidst i kapitlet.)

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

*Bedste og værste tilfælde:* $O(n + k)$ i alle tilfælde, uafhængigt af
elementernes rækkefølge. Det afgørende er forholdet mellem nøgleintervallet $k$ og
$n$: effektiv når $k = O(n)$, men både langsom og pladskrævende når $k >> n$,
fordi tæller-arrayet $C$ har længde $k + 1$.

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

*Bedste og værste tilfælde:* $O(d(n + k))$ i alle tilfælde, uafhængigt af
elementernes rækkefølge. Afhænger af antal cifre $d$ og cifferintervallet $k$
(typisk $k = 10$), ikke af rækkefølgen: dyrere jo flere cifre $d$ tallene har.


== Sammenligningstabel

#table(
  columns: 6,
  align: (left, center, center, center, center, center),
  table.header([Algoritme], [Bedste], [Gennemsnit], [Værste], [Stabil], [In-place]),
  [Insertionsort], $O(n)$, $O(n^2)$, $O(n^2)$, [Ja], [Ja],
  [Selectionsort], $O(n^2)$, $O(n^2)$, $O(n^2)$, [Nej], [Ja],
  [Mergesort], $O(n log n)$, $O(n log n)$, $O(n log n)$, [Ja], [Nej],
  [Quicksort], $O(n log n)$, $O(n log n)$, $O(n^2)$, [Nej], [Ja],
  [Heapsort], $O(n log n)$, $O(n log n)$, $O(n log n)$, [Nej], [Ja],
  [Counting sort], $O(n + k)$, $O(n + k)$, $O(n + k)$, [Ja], [Nej],
  [Radix sort], $O(d(n + k))$, $O(d(n + k))$, $O(d(n + k))$, [Ja], [Nej],
)

*Vigtig pointe:* Kun *insertionsort* og *quicksort* er følsomme over for inputtets
orden — dvs. har et bedste tilfælde der adskiller sig fra det værste afhængigt af
arrangementet. Insertionsort er hurtigst ($O(n)$) på allerede sorteret input og
langsomst ($O(n^2)$) på omvendt sorteret. Quicksort rammer sit værste tilfælde
($O(n^2)$) når pivotvalget giver maksimalt skæve opdelinger (med sidste-element-
pivot sker det netop på sorteret/næsten sorteret input). De øvrige fem algoritmer
har samme asymptotiske køretid uanset inputtets orden.


== Eksamenstips og faldgruber

=== PARTITION (CLRS / Quicksort): tjek og simulér resultatet
*Algoritmen (Lomuto partition scheme, CLRS-version):*

```
PARTITION(A, p, r):
    x = A[r]           // pivot er ALTID det sidste element i subarrayet
    i = p - 1
    for j = p to r-1:
        if A[j] <= x:
            i = i + 1
            swap(A[i], A[j])
    swap(A[i+1], A[r])
    return i+1          // pivots endelige indeks
```

*1. Pivot er IKKE midten af subarrayet.* Pivots endelige plads er IKKE det
geometriske midtpunkt af subarrayet. Den bestemmes udelukkende af VÆRDIERNE:
$ "Pivots endelige indeks" = p + k - 1 $
hvor $k$ = antal elementer i subarrayet (inkl. pivot selv) der er $<=$ pivot.
Eksempel: subarray fra indeks 4–13, pivot $= A[13]$. Tæl hvor mange elementer
(inkl. pivot) er $<=$ pivot → det tal $k$ fortæller hvilken plads (talt fra $p$)
pivot ender på.

*2. Pivot-egenskaben er NØDVENDIG men ikke TILSTRÆKKELIG.* Et korrekt
PARTITION-resultat skal opfylde:
- Alt til venstre for pivots endelige plads er $<=$ pivot.
- Alt til højre for pivots endelige plads er $>$ pivot.
- Pivot selv står på sin endelige plads.

MEN: Der findes ofte FLERE mulige arrangementer af elementerne, der alle opfylder
denne egenskab. Kun ÉT af dem er det algoritmen faktisk producerer — fordi
algoritmen bygger sin omrokering op via en bestemt, deterministisk sekvens af
swaps.

→ Pivot-egenskaben kan bruges til at UDELUKKE forkerte svarmuligheder, men kan
IKKE bruges til at afgøre mellem flere svar der alle ser "gyldige" ud. For det
skal man SIMULERE algoritmen trin for trin.

*3. Elementer UDENFOR det relevante subarray ($p$ til $r$) ændres ikke.* Hvis
opgaven f.eks. siger $"PARTITION"(A, 4, 13)$, men arrayet har 15 elementer, så
rører algoritmen IKKE ved indeks 1–3 eller 14–15. Tjek altid at disse forbliver
uændrede i svarmulighederne — det er en hurtig måde at udelukke forkerte svar
(selvom det ikke nødvendigvis skiller alle svar fra hinanden).

*Metode til at løse denne opgavetype:*
+ Identificer subarrayet ($p$ til $r$) og pivot ($= A[r]$).
+ Brug $k$-formlen til at beregne pivots forventede endelige indeks. Brug dette til hurtigt at udelukke svar hvor pivot står forkert.
+ Tjek pivot-egenskaben (venstre $<=$ pivot, højre $>$ pivot) for at udelukke flere svar.
+ Hvis flere svar stadig ser gyldige ud: SIMULÉR algoritmen trin for trin (lav en tabel med $j$, $A[j]$, sammenligning, evt. swap, og opdateret array) for at finde det NØJAGTIGE resultat.
+ Husk det sidste skridt: $"swap"(A[i+1], A[r])$ — pivot flyttes fra sin oprindelige plads ($r$) til sin endelige plads ($i+1$) til sidst.

*Eksempel på simulationstabel:*

#table(
  columns: 6,
  align: (center, center, center, left, center, left),
  table.header([$j$], [$A[j]$], [$A[j] <= "pivot"?$], [Handling], [$i$ efter], [Array]),
  […], […], […], [swap($A[i], A[j]$) eller intet], […], […],
)

Efter loopet: $"swap"(A[i+1], A[r])$ for at placere pivot korrekt.

=== CountingSort: køretiden afhænger af både $n$ og $k$
*Fælde:* Man tror nemt at CountingSort altid er $Theta(n)$. Det er den ikke.

*Den rigtige formel:*
$ Theta(n + k) $
hvor:
- $n$ = antal elementer der skal sorteres.
- $k$ = størrelsen af værdiintervallet (antal mulige værdier).

*Hvorfor:* Algoritmen opretter et "counting array" med ét felt per mulig værdi i
intervallet. Det array skal initialiseres og gennemløbes, uanset hvor mange af
felterne der reelt bliver brugt. Det er det skridt der kan dominere køretiden,
hvis $k$ er stor.

*Eksempel — værdier i $[0; n^c[$:*
$ k = n^c $
$ Theta(n + n^c) = Theta(n^c) quad "for" c > 1 $
$ Theta(n) quad "for" c = 1 $

#table(
  columns: 3,
  align: (center, center, center),
  table.header([Værdiinterval], [$k$], [Køretid]),
  $[0; n[$, $n$, $Theta(n)$,
  $[0; n^3[$, $n^3$, $Theta(n^3)$,
  $[0; n^9[$, $n^9$, $Theta(n^9)$,
)

*Konklusion:* CountingSort er kun hurtig (lineær) når $k$ er $O(n)$ (eller i hvert
fald polynomielt lille ift. $n$). Hvis værdiintervallet vokser hurtigere end $n$,
bliver CountingSort dårligere end fx MergeSort ($Theta(n log n)$) — selv om
antallet af elementer der sorteres er uændret.

*Tommelfingerregel:* Kig altid på BÅDE $n$ og $k$, før du konkluderer noget om
CountingSorts køretid.

=== Heapsort på $n$ identiske elementer
*Spørgsmål.* Hvad er worst-case køretiden for Heapsort på $n$ identiske
elementer? *Svar:* $O(n)$ — ikke $O(n log n)$, som man normalt forventer for
Heapsort.

*Heapsort i to faser:*
+ *Build-heap:* opbygger en max-heap af de $n$ elementer — $O(n)$.
+ *Extract-max $n$ gange:* tager roden ud og kører sift-down/heapify for at genoprette heap-egenskaben — normalt $O(log n)$ per kald, altså $O(n log n)$ i alt.

Den almindelige worst-case-analyse ($O(n log n)$) regner med at sift-down typisk
skal vandre hele vejen ned igennem træet ($O(log n)$ niveauer).

*Hvorfor identiske elementer ændrer dette.* Når alle elementer er identiske:
- Sift-down sammenligner forælder med dens børn for at se om de skal bytte plads.
- Standard-implementeringen bytter kun hvis et barn er *strengt større* end forælderen.
- Da alle værdier er ens, er intet barn strengt større — der sker ingen swaps overhovedet.
- Sift-down stopper derfor med det samme ($O(1)$) i stedet for at vandre $O(log n)$ niveauer ned.

*Konsekvens for køretiden:*
- Build-heap: stadig $O(n)$.
- De $n$ extract-max-operationer: hver tager nu $O(1)$ i stedet for $O(log n)$.
- Total: $n times O(1) = O(n)$.

*Vigtig pointe.* Dette er ikke i modstrid med at Heapsorts worst-case generelt er
$Theta(n log n)$ for *vilkårlige* inputs. Med identiske elementer rammer man et
specifikt scenarie for sift-down (ingen byt sker), som giver en hurtigere kørsel
end den generelle øvre grænse.

*Læring.* Heapsorts $O(n log n)$-bound kommer fra antallet af niveauer et element
skal sive igennem under sift-down. Det antal kan kollapse til $O(1)$, hvis
sammenligningerne aldrig udløser et byt — hvilket sker når ingen børn er strengt
større end deres forælder (fx ved identiske elementer).
