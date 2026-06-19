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
Før vi begynder at fremstille en algoritme der kan løse vores problem, vil vi
gerne kende voksehastigheden af de forskellige algoritmer så vi kan vælge den
hurtigste. Det gør vi i det her kursus med RAM-modellen, som er bevist at
afspejle rigtig køretid ret godt.

Når vi sammenligner forskellige voksehastigheder, er konstanter der bliver
ganget på ligegyldige. Det vil altid være ledet der indebærer voksehastigheden
(det led hvor $n$ befinder sig), som dominerer.

#figure(
  image("figures/multipliedconstants.png", width: 70%),
  caption: [På grafen ser vi at funktionerne $h(n)$ og $k(n)$ altid vil overhale
    $f(n)$ og $g(n)$, selvom deres konstant er betydelig mindre.],
)

For at simplificere analysen af algoritmer bruger vi asymptotisk notation. Ved
asymptotisk notation betragter vi alle konstanter der bliver ganget på for ens
($c$).

#figure(
  image("figures/asymptoticnotation.png", width: 70%),
  caption: [Det vil sige alle algoritmer med samme voksehastighed bliver
    betragtet som lige gode.],
)

Vi kan nu bruge følgende relationer til at sammenligne voksehastigheder, som
hver især har en betegnelse:

#table(
  columns: 3,
  align: (center, center, left),
  table.header([Relation], [Betegnelse], [Udtales]),
  $<=$, $O$, [O],
  $>=$, $Omega$, [Omega],
  $=$, $Theta$, [Theta],
  $<$, $o$, [Lille o],
  $>$, $omega$, [Lille omega],
)

=== O (øvre grænse)
$ f(n) = O(g(n)) $
Hvis der findes en $c > 0$ og grænse $N_0$, hvor der for alle $n$ efterfølgende
($n >= N_0$), gælder:
$ f(n) <= c dot g(n) $

#figure(
  image("figures/bigodefinition.png", width: 70%),
  caption: [$g(n)$ sætter loftet for hvor hurtigt $f(n)$ må vokse.],
)

Det betyder altså at $g(n)$ sætter loftet for, hvor hurtigt $f(n)$ må vokse.
$f(n)$ må gerne vokse samme hastighed, som $g(n)$. Der er ikke noget loft for
hvor meget hurtigere $g(n)$ må vokse end $f(n)$.

=== Ω (nedre grænse)
$ f(n) = Omega(g(n)) $
Hvis der findes en $c > 0$ og grænse $N_0$, hvor der for alle $n$ efterfølgende
($n >= N_0$), gælder:
$ f(n) >= c dot g(n) $

#figure(
  image("figures/bigomegadefinition.png", width: 70%),
  caption: [$g(n)$ sætter gulvet for hvor hurtigt $f(n)$ skal vokse.],
)

Det betyder altså at $g(n)$ sætter gulvet for, hvor hurtigt $f(n)$ skal vokse.
$f(n)$ må gerne vokse samme hastighed, som $g(n)$. Der er ikke noget loft for
hvor meget hurtigere $f(n)$ må vokse end $g(n)$.

=== Θ
$ f(n) = Theta(g(n)) $
Hvis der findes konstanter $c_1, c_2 > 0$ og en grænse $N_0$, hvor der for alle
$n$ efterfølgende ($n >= N_0$), gælder:
$ f(n) = O(g(n)) quad "og" quad f(n) = Omega(g(n)) $
Som også kan beskrives:
$ c_2 dot g(n) <= f(n) <= c_1 dot g(n) $

#figure(
  image("figures/thetadefinition.png", width: 70%),
  caption: [$f$ skal altid ligge mellem de to funktioner med hver sin konstant.],
)

Det betyder at funktion $f$ skal altid ligge mellem de to funktion $g$, der har
hver sin konstant, efter grænsen $N_0$.

=== o (streng øvre grænse)
$ f(n) = o(g(n)) $
Hvis der for alle $c > 0$ findes en grænse $N_0$, så der for alle $n$
efterfølgende ($n >= N_0$) gælder:
$ f(n) <= c dot g(n) $
Som også kan fortolkes som:
$ f(n) < c dot g(n) $
Fungerer altså ligesom store o, men $f$ må ikke længere vokse samme hastighed
som $g$.

=== ω (streng nedre grænse)
$ f(n) = omega(g(n)) $
Hvis der for alle $c > 0$ findes en grænse $N_0$, så der for alle $n$
efterfølgende ($n >= N_0$) gælder:
$ f(n) >= c dot g(n) $
Som også kan fortolkes som:
$ f(n) > c dot g(n) $
Fungerer altså ligesom store omega, men $f$ må ikke længere vokse samme
hastighed som $g$.

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
