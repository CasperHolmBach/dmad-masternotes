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
_Noter tilføjes._
