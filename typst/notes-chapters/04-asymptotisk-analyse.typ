= Asymptotisk analyse
// Del B — Algoritmer og Datastrukturer · slides: asymptoticAnalysis, algoritmeAnalyseIntro, invariantSlides

== Hvad er en algoritme?
En algoritme er en betegnelse for en trinvis opskrift for hvordan en computer
kan løse en given opgave eller problem. Den tager imod et input, bearbejder det,
og returnerer et output, som er resultatet af algoritmen.

Mindstekravet for algoritmer er at de kan betegnes som *korrekte*:
- Algoritmen er ikke en uendelig løkke, og den stopper for inputs.
- Algoritmen giver et korrekt svar på det problem vi forsøger at løse med den.

En korrekt algoritme kan derudover have forskellige kvaliteter:
- Hastighed
- Pladsforbrug (RAM / Memory)
- Kompleksitet af implementation
- Ekstra problemspecifikke egenskaber

== Analyse af en algoritme
Vi er ofte interesseret i at måle disse kvaliteter af en algoritme. For at kunne
analysere en algoritme skal man bruge følgende:
- Model af problem
  - Definer input og output.
- Model af maskine
  - Hvilket "type" computer kører algoritmen på? I dette kursus bruges
    RAM-modellen, hvor grundlæggende operationer tager konstant tid.
- Mål for kvalitet
  - I dette kursus fokuserer vi på at analysere tidsforbrug.
- Matematiske værktøjer
  - Asymptotisk notation til at beskrive køretidsvækst.
  - Invarianter der skal være sande under hele kørslen.
  - Induktion som bevisteknik.
  - Rekursionsligninger der beskriver køretid for rekursive algoritmer.

== Best, average og worst case
Vi kan generelt måle en algoritmes hastighed i enten best, average eller worst
case. Dog giver det bedst mening at måle i *worst case*-køretid, da dette giver
os en garanti for hvad vi kan forvente. En worst case er ofte en voksende
funktion.

== Definitioner
_Noter tilføjes (O, Ω, Θ, o, ω)._

== Sammenligning af voksehastigheder
For at sammenligne to algoritmers køretid skal vi sammenligne to funktioner, for
at se hvordan hver algoritme vokser når inputtet $n$ stiger.

#figure(
  image("figures/fnandgn.png", width: 70%),
  caption: [Som ses på grafen overstiger $g(n)$ altid $f(n)$ på et tidspunkt, og
    derfor har $g(n)$ altså en større voksehastighed end $f(n)$.],
)

== Vækstratehierarki
Voksehastigheder kan opstilles fra hurtigst til langsomst som følgende:

#figure(
  image("figures/timecomplexityrank.png", width: 55%),
  caption: [Voksehastigheder ordnet fra hurtigst til langsomst.],
)

Visualisering af forskellige køretider:

#figure(
  image("figures/timecomplexitygraph.png", width: 85%),
  caption: [Visualisering af forskellige køretider.],
)

== Analyse af løkker i hånden
_Noter tilføjes (udledning af Θ-køretid for indlejrede løkker)._

== Eksamenstips og faldgruber
_Noter tilføjes._
