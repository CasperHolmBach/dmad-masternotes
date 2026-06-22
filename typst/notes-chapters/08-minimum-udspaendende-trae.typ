= Minimum udspændende træ
// Del B — Algoritmer og Datastrukturer · slides: mstSlides


== Frie træer og MST
Et frit / u-rodet træ er en uorienteret graf, som er:
- *Sammenhængende:* der er en sti mellem alle par af knuder
- *Acyklisk:* der er ingen kreds af kanter

Et MST definerer et udspændende træ, som en delgraf med samme knudemængde, der er
et træ. MST er det udspændende træ med mindst mulig sum af kantvægte. Motivationen
er billigst mulig sammenkobling af punkter, f.eks. i forsyningsnetværk.

Idéen for at bygge en MST er gennem en grådig algoritme, der bygger MST'en kant
for kant. Invarianten for løsningen er: "der findes et MST, som indeholder de
valgte kanter A". Man kalder en kant for en "safe" kant, hvis den kan tilføjes til
MST uden at bryde den nævnte invariant.

#figure(
  image("figures/mstpseudo.png", width: 65%),
  caption: [`GENERIC-MST`: tilføj gentagne gange en safe kant til $A$.],
)


== Snit-egenskaben (cut property)
Et redskab til at finde safe kanter. Cuts laver en opdeling af knuderne i to
mængder: $S$ og $V - S$.

#figure(
  image("figures/cuts.png", width: 85%),
  caption: [Et cut $(S, V - S)$. Den letteste kant der krydser cuttet er safe.],
)

Hvis
- Der eksisterer et MST, som indeholder A (A = de kanter algoritmen har valgt indtil videre til at opbygge MST)
- S er et cut, som A ikke har kanter henover, altså mine allerede valgte kanter A skal alle sammen have sine kanter på én af siderne.
- Kig på alle kanter, der krydser cuttet, og find den billigste kant. Den kaldes for $e$.

Så
- Er $e$ safe for A

Vi kan omsætte den abstrakte cut-sætning til en konkret praktisk regel, som kan
bruges i en algoritme:
- *Kanter inde i samme komponent er aldrig safe* – En ny kant $(u, v)$ med begge endepunkter i samme sammenhængskomponent vil introducere en kreds og dermed ødelægge invarianten.
- *Kanter mellem forskellige komponenter* – En ny kant $(u, v)$ med endepunkterne i forskellige sammenhængskomponenter $C_1$ og $C_2$ er safe, hvis det er den letteste kant ud af $C_1$.


== Prim-Jarnik-algoritmen
Starter fra en knude $r$ og udvider gradvist dens sammenhængskomponent ved altid
at tilføje den letteste kant ud af komponenten.

#figure(
  image("figures/primjarnik.png", width: 75%),
  caption: [Prim-Jarnik: komponenten vokser fra startknuden ved den letteste udgående kant.],
)

Prim-Jarnik algoritmen har en køretid på $O(m log n)$ med en binær heap.


== Kruskals algoritme
Bruger en anden strategi: tilføj kanter i global-letteste først orden.

#figure(
  image("figures/kruskalpseudo.png", width: 75%),
  caption: [`KRUSKAL`: sortér kanterne, og tilføj en kant hvis dens endepunkter ligger i hver sin komponent.],
)

Kruskal benytter disjoint set datastrukturen til at holde styr på hvilke knuder
der er i samme komponent.

#figure(
  image("figures/kruskalmst.png", width: 70%),
  caption: [Kruskal trin for trin (a–h).],
)

#figure(
  image("figures/kruskalmst2.png", width: 80%),
  caption: [Kruskal trin for trin, fortsat (i–n).],
)

Kruskal MST-algoritmen har en køretid på $O(m log m)$.


== Eksamenstips og faldgruber
_Noter tilføjes._
