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


== Asymptotisk forhold via grænseværdier
Har man to funktioner, $f(n)$ og $g(n)$, kan man finde det asymptotiske forhold
mellem dem ved at bruge følgende to sætninger, uden at kende $c$ og $N_0$:

*Sætning 1:* Hvis $ f(n)/g(n) -> k > 0 quad ("en positiv konstant") quad "når" n -> oo $
så gælder
$ f(n) = Theta(g(n)) $
Det vil sige, at hvis forholdet mellem $f$ og $g$ konvergerer mod et fast
positivt tal, betyder det at de to funktioner vokser lige hurtigt.

Eksempel:
$ f(n) = 20n^2 + 17n + 312 $
$ g(n) = n^2 $
$ f(n)/g(n) = (20n^2 + 17n + 312)/n^2 = 20 + 17/n + 312/n^2 -->_(n -> oo) 20/1 = 20 $
Eftersom 20 er en positiv konstant betyder det at: $f(n) = Theta(n^2)$.

*Sætning 2:* Hvis $ f(n)/g(n) -> 0 quad "når" n -> oo $
så gælder
$ f(n) = o(g(n)) $
Det vil sige, at hvis $f$ divideret med $g$ går mod nul, betyder det at $f$
bliver relativt forsvindende lille i forhold til $g$, altså vokser $f$ strengt
langsommere end $g$.

Eksempel:
$ f(n) = 20n^2 + 17n + 312 $
$ g(n) = n^3 $
$ f(n)/g(n) = (20n^2 + 17n + 312)/n^3 = 20/n + 17/n^2 + 312/n^3 -->_(n -> oo) 0/1 = 0 $
Eftersom forholdet går mod 0 betyder det at: $f(n) = o(n^3)$.


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


== Invarianter
En invariant er et forhold som vedligeholdes af algoritmen i løbet af dens
udførelse. Et eksempel på en invariant kan være i insertionsort, hvor alt til
venstre for den nuværende key (sorte felt) skal være sorteret.

#figure(
  image("figures/insertioninvariant.png", width: 85%),
  caption: [Invarianten i insertionsort: alt til venstre for den nuværende key er
    altid sorteret.],
)

Ofte udgør invarianten selve kerneidéen af algoritmen, og kan også bruges som
belæg for at algoritmen virker.

En invariant skal overholdes efter hvert skridt (iteration af løkke) udført af
algoritmen. Dette kan bevises ved hjælp af induktion:

#figure(
  image("figures/invariantinduction.png", width: 75%),
  caption: [Induktionsprincippet: holder invarianten i basistilfældet, og bevarer
    hvert skridt den, så gælder den gennem hele kørslen.],
)


== Analyse af løkker i hånden
Man kan som tommelfingerregel analysere en algoritmes køretid på hvor mange
nestede loops de anvender:

#figure(
  image("figures/1loop.png", width: 60%),
  caption: [Her har vi ét loop, så køretiden er $Theta(n)$.],
)

#figure(
  image("figures/2loop.png", width: 60%),
  caption: [Her har vi to nestede loops, så køretiden er $Theta(n^2)$.],
)

#figure(
  image("figures/3loop.png", width: 60%),
  caption: [Her har vi tre nestede loops, så køretiden er $Theta(n^3)$.],
)


== Eksamenstips og faldgruber

=== De fem notationer og hvad de betyder
- *$O(g(n))$:* $f$ vokser HØJST så hurtigt som $g$ ($<=$)
- *$Omega(g(n))$:* $f$ vokser MINDST så hurtigt som $g$ ($>=$)
- *$Theta(g(n))$:* $f$ vokser LIGE så hurtigt som $g$ ($=$)
- *$o(g(n))$:* $f$ vokser STRENGT langsommere end $g$ ($<$) — "lille o"
- *$omega(g(n))$:* $f$ vokser STRENGT hurtigere end $g$ ($>$) — "lille omega"

*Tommelfingerregel:* store bogstaver ($O$, $Omega$, $Theta$) tillader "lige
hurtigt", små bogstaver ($o$, $omega$) kræver en STRENG ulighed (ikke lige
hurtigt).

=== Fejl 1: $(log n)^k$ forveksles med $n^k$
*Fejlen:* At tro $(log n)^3$ vokser ligesom $n^3$, eller endda i nærheden af det.

*Det rigtige:* $(log n)^3$ betyder $log n$ ganget med sig selv 3 gange — IKKE
$log(n^3)$. Begge er stadig MEGET mindre end $n$.

Eksempel med konkrete tal (log med grundtal 2):

#table(
  columns: 4,
  align: (center, center, center, center),
  table.header([$n$], [$log n$], [$(log n)^3$], [$n^3$]),
  $8$, $3$, $27$, $512$,
  $1024$, $10$, $1000$, $1.07 dot 10^9$,
  $10^6$, $approx 20$, $approx 8000$, $10^18$,
)

*Generel regel at huske:* For enhver konstant $k$ og enhver $epsilon > 0$:
$ (log n)^k = O(n^epsilon) $
En logaritme i en hvilken som helst potens vokser STADIG langsommere end $n$
opløftet i selv den mindste positive potens.

=== Fejl 2: Konstanter og lille-o
*Fejlen:* At tro at "$6$ er $o(7)$" er sandt, fordi $6 < 7$.

*Det rigtige:* $o(g(n))$ kræver at grænseværdien
$ lim_(n -> oo) f(n)/g(n) = 0 $
Men $6 \/ 7$ er en KONSTANT, uafhængig af $n$. Grænsen er $6 \/ 7$, ikke $0$. Så
"$6$ er $o(7)$" er FALSK — det er derimod $O(7)$ og $Theta(7)$, men ikke $o(7)$.
Lille-o handler om forskel i VÆKSTRATE, ikke om hvilket tal er størst.

=== Generel vækstrate-rækkefølge (langsomst til hurtigst)
$ 1 << log n << (log n)^k << n^epsilon << n << n log n << n^2 << dots.c << 2^n << 3^n << n! << n^n $

Brug denne skala til hurtigt at afgøre $O \/ Omega \/ Theta \/ o \/ omega$ mellem
to udtryk:
- $f$ til venstre for / samme sted som $g$ → $f$ er $O(g)$
- $f$ strengt til venstre for $g$ → $f$ er $o(g)$
- osv. (spejlvendt for $Omega$ og $omega$)

=== Praktisk tjekliste til denne opgavetype
+ Identificer hvilken notation der bruges (stort/småt bogstav, hvilket symbol).
+ Placer begge funktioner på vækstrate-skalaen ovenfor.
+ Tjek om uligheden skal være streng ($o$, $omega$) eller kan være lige ($O$, $Omega$, $Theta$).
+ Pas på "snyde"-udtryk: $(log n)^k$, konstanter sat i forhold til konstanter, og udtryk der ligner hinanden visuelt men er meget forskellige (f.eks. $(log n)^3$ vs $log(n^3)$ vs $n^3$).
