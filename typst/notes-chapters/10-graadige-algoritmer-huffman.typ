= Grådige algoritmer og Huffman-kodning
// Del B — Algoritmer og Datastrukturer · slides: greedySlides


== Det grådige princip
Et algoritme-konstruktionsparadigme for kombinatoriske optimeringsproblemer. Idéen
bag grådige algoritmer er at opbygge en løsning bid for bid ved hele tiden at vælge
hvad der lige nu ser ud til at være det bedste valg.

Man håber på at lokal optimering giver global optimering.

En grådig algoritme kræver en definition af "det bedste valg lige nu". Det kaldes
også en heuristik.


=== Eksempel: skeduleringsproblem
Input: en samling booking-ønsker for en ressource, hver med en starttid og sluttid.

Output: en størst mulig mængde ikke-overlappende bookings.

#figure(
  image("figures/greedyscheduling.png", width: 85%),
  caption: [En samling booking-ønsker langs tidsaksen.],
)

Opgaven er her at definere det grådige valg. Vi kan selvfølgelig ikke vælge en
aktivitet $x$, som har overlap med nogle af de allerede valgte aktiviteter i $S$.
Forskellige forslag til at vælge en aktivitet kunne være:
- Den korteste aktivitet
- Den aktivitet, der overlapper med færrest af de andre tilbageværende aktiviteter
- Den aktivitet der starter først
- Den aktivitet der slutter først

Det viser sig, at de tre første forslag ender i en suboptimal global løsning. En
visualisering for den fjerde ses her:

#figure(
  image("figures/greedyschedulefour.png", width: 65%),
  caption: [Grådigt valg: sortér efter stigende sluttid, og vælg en aktivitet hvis den ikke overlapper de allerede valgte.],
)

Invariant: Der findes altid en optimal løsning OPT, som indeholder alle de
aktiviteter, algoritmen indtil nu har valgt.


=== Eksempel 2: rygsækproblemet
Rygsæk kan være $w$ kg. Målet er at medbringe mest mulig værdi uden at overskride
vægtgrænsen.

#figure(
  image("figures/backpackproblem.png", width: 75%),
  caption: [Et input til rygsækproblemet: ting med hver sin vægt $w_i$ og værdi $v_i$.],
)

Problemet kan udvides til to former. Én hvor man må medbringe dele af ting. Her vil
en grådig strategi der vælger ting i faldende orden $"værdi" / "vægt"$ være optimal.
Dog hvis problemet kun tillader at tage det hele eller ingenting, så giver den samme
heuristik ikke en optimal løsning. Et grådigt valg må ikke antages at virke på alle
cases.

#figure(
  image("figures/backpackgreedy.png", width: 90%),
  caption: [Den fraktionelle variant løses optimalt grådigt; den 0/1-variant gør den ikke.],
)


== Huffman-kodning
Fixed-width bit koder, der blandt andet oversætter til ASCII, er ikke optimale. Det
skyldes at selv de mest hyppige tegn fylder lige så mange bits som de mindst
hyppige. Man kan derfor med fordel bruge variable-width bit koder. Her får de mest
hyppige tegn, som 'a', en kort kode der ikke fylder så meget, imens sjældnere tegn,
som 'f', får en længere kode. På den måde er det muligt at spare plads på
filstørrelser.


=== Prefix kode
En kode hvor intet tegns kodeord er begyndelsen (prefixet) af et andet tegns
kodeord. Dette giver utvetydig afkodning, eftersom man kan læse en bitstrøm bit for
bit og man altid ved præcis hvornår et kodeord er færdigt.

#figure(
  image("figures/huffmantree.png", width: 40%),
  caption: [En prefix-kode som et binært træ: hvert blad er et tegn, og vejen fra roden giver kodeordet.],
)


=== Huffmans algoritme
Bygger et træ op nedefra ud fra mindste til største frekvenser, ved hele tiden at
lave det grådige valg: "Slå de to deltræer med de to mindste samlede frekvenser
sammen":

#figure(
  image("figures/huffmanalgorithm.png", width: 85%),
  caption: [Huffmans algoritme: deltræerne slås sammen to ad gangen efter mindste samlede frekvens.],
)

Den samlede køretid for huffmans-algoritme er $O(n log n)$.


== Eksamenstips og faldgruber

=== Huffman-træ: byg det og find kodelængder
*Grundprincippet.* Huffman-algoritmen bygger et binært træ bottom-up, ved
gentagne gange at slå de to MINDSTE frekvenser sammen til en ny node, indtil kun
ét træ (roden) er tilbage.

*Algoritmen, trin for trin:*
+ Læg alle tegn i en pulje, sorteret efter hyppighed.
+ Gentag indtil kun ét element er tilbage i puljen:
  - Tag de to elementer med LAVEST frekvens ud af puljen.
  - Slå dem sammen til en ny node, hvis frekvens = summen af de to.
  - Læg den nye (sammensatte) node TILBAGE i puljen.
+ Det sidste element der er tilbage er roden af træet.

*VIGTIG POINTE — sammensatte noder går tilbage i puljen.* Når to elementer slås
sammen til en ny node (f.eks. $c:100$ og $a:200$ bliver til $(c a):300$),
behandles denne nye node som et HELT ALMINDELIGT element i puljen i alle
efterfølgende runder.
- Algoritmen er ligeglad med om en node er et originalt tegn eller en tidligere sammensætning — den kigger KUN på frekvensværdien.
- Den sammensatte node konkurrerer på lige fod med resten af puljen om at blive valgt som "en af de to mindste" i næste runde.
- Træets struktur (hvilke børn en node har) "huskes" undervejs, men det er kun frekvens-TALLET der bruges til at afgøre rækkefølgen af sammenlægninger.

*Eksempel.* Tegn med hyppigheder: $c:100$, $a:200$, $b:250$, $d:350$, $e:400$.
- Trin 1: Mindste to er $c(100)$ og $a(200)$ → ny node $(c a):300$. Pulje nu: $b:250$, $(c a):300$, $d:350$, $e:400$.
- Trin 2: Mindste to er $b(250)$ og $(c a)(300)$ → ny node $(b, c a):550$. Pulje nu: $d:350$, $e:400$, $(b, c a):550$.
- Trin 3: Mindste to er $d(350)$ og $e(400)$ → ny node $(d e):750$. Pulje nu: $(b, c a):550$, $(d e):750$.
- Trin 4: Sidste to slås sammen til roden: $550 + 750 = 1300$.

*Sådan finder man kodelængden for et tegn.* Kodelængden = antal niveauer (kanter)
fra roden ned til tegnets blad i træet. Tæl simpelthen hvor mange "hop" der er fra
roden til bladet. I eksemplet ovenfor:
- $d$ og $e$ ligger 2 niveauer fra roden → 2 bits hver.
- $b$ ligger 2 niveauer fra roden → 2 bits.
- $c$ og $a$ ligger 3 niveauer fra roden (de er børn af $(c a)$, som er barn af $550$) → 3 bits hver.

*Tjekliste til denne opgavetype:*
+ Sorter tegnene efter hyppighed.
+ Slå de to mindste sammen, læg resultatet tilbage i puljen.
+ Gentag — husk at sammensatte noder tæller på lige fod med originale tegn i de følgende runder.
+ Fortsæt til kun roden er tilbage.
+ Tæl niveauer fra rod til det ønskede tegns blad for at finde kodelængden (antal bits).
