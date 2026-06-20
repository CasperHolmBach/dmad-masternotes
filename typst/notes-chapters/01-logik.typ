= Logik
// Del A — Diskret Matematik · Rosen kap. 1


== Logiske udsagn
Et logisk udsagn er en påstand som enten kan være sandt eller falsk:
- $1 + 1 = 2$ — Sandt
- $3 > 5$ — Falsk


== Logiske operatorer
Der findes forskellige logiske operationer.

*$not$ — negation:* fungerer som NOT.

#figure(
  image("figures/negation.png", width: 25%),
  caption: [Sandhedstabel for negation.],
)

*$and$ — konjunktion:* fungerer som AND. \
*$or$ — disjunktion:* fungerer som OR.

#figure(
  image("figures/andandor.png", width: 55%),
  caption: [Sandhedstabel for konjunktion og disjunktion.],
)

*$arrow.r.double$ — implikation:* én ting medfører en anden.

#figure(
  image("figures/implication.png", width: 45%),
  caption: [Sandhedstabel for implikation.],
)

Eksempel på implikation i virkeligheden:

#figure(
  image("figures/implicationex.png", width: 80%),
  caption: [Bemærk: udsagnet siger kun noget om tilfældet hvor $b$ er sandt.
    $b arrow.r.double t$ er ensbetydende med det kontrapositive
    $not t arrow.r.double not b$.],
)

Det viser sig også at den omvendte implikation mellem to negerede udsagn giver
samme sandhedstabel:

#figure(
  image("figures/truthtable.png", width: 90%),
  caption: [$p arrow.r.double q$ og $not q arrow.r.double not p$ har samme
    sandhedstabel.],
)

- $not q arrow.r.double not p$ kaldes for det *kontrapositive* udsagn af $p arrow.r.double q$.
- $q arrow.r.double p$ kaldes for det *omvendte* udsagn af $p arrow.r.double q$.
- $not p arrow.r.double not q$ kaldes for det *inverse* udsagn af $p arrow.r.double q$.

*$arrow.l.r.double$ — biimplikation:* $p$ er ensbetydende med $q$ (samme
sandhedsværdi).

#figure(
  image("figures/biimplication.png", width: 90%),
  caption: [Sandhedstabel for biimplikation.],
)

Det vil altså sige: $p arrow.l.r.double q equiv (p arrow.r.double q) and (q arrow.r.double p)$.

*$plus.o$ — eksklusiv disjunktion:* fungerer som XOR.

#figure(
  image("figures/xor.png", width: 35%),
  caption: [Sandhedstabel for XOR.],
)


== Præcedens
Præcedenshierarkiet for logiske operatorer er:

$ not quad and quad or quad arrow.r.double quad arrow.l.r.double $

Der er ikke enighed om hvor $plus.o$ befinder sig, så her må der bruges parenteser.


== Terminologi
- *Tautologi:* Et sammensat udsagn, som er sandt uanset sandhedsværdien af de
  udsagnsvariable, som indgår — det vil sige alt resulterer i sandt.
- *Modstrid:* Et sammensat udsagn, som er falsk uanset sandhedsværdien af de
  udsagnsvariable, som indgår — det vil sige alt resulterer i falsk.
- *Kontingens:* Alle andre udsagn der hverken er en tautologi eller modstrid —
  det vil sige der er mindst én række der giver sandt og én der giver falsk.


== Talmængder
- $ZZ$: Alle heltal
- $ZZ^+$: Alle positive heltal
- $ZZ^-$: Alle negative heltal
- $NN$: Alle naturlige tal (ingen negative by default)
- $QQ$: Rationale tal (alle heltal + ikke-uendelige brøker)
- $RR$: Alle tal der kan placeres på en uendelig tallinje


== Kvantorer
- $forall$: Allekvantor — "for alle"
- $exists$: Eksistenskvantor — "der eksisterer"

Kvantorer kan benyttes til at beskrive en løsning til et sandhedsudtryk som
indeholder en fri variabel. F.eks.:

$ P(x): 2x > x $

Eftersom dette udsagn er åbent, kan der være nogle værdier der resulterer i
falsk og nogle andre i sandt:
- $P(-1): -2 > -1$ — Falsk
- $P(0): 0 > 0$ — Falsk
- $P(1): 2 > 1$ — Sandt
- $P(2): 4 > 2$ — Sandt

Det kan ses at der er en "trend": $P(1) and P(2) and P(3) and ...$ er sandt.

Men dette tager lang tid at beskrive, så i stedet kan vi benytte kvantorer. I
dette tilfælde allekvantoren:

$ P(1) and P(2) and P(3) and ... $
$ arrow.t.b.double $
$ forall x in ZZ^+ : P(x) $
$ arrow.t.b.double $
$ forall x in ZZ^+ : 2x > x $

De individuelle elementer kan læses som:
- $forall$: for alle
- $ZZ^+$: universet / domænet
- $:$ gælder
- $2x > x$: udsagn

Sammensat: "For alle $x$ i mængden af positive heltal gælder $2x > x$".

Et andet eksempel:

#figure(
  image("figures/forallex.png", width: 65%),
  caption: [Den samme allekvantor kan skrives på flere ækvivalente måder.],
)

Eksistenskvantoren kan bruges på samme måde til at beskrive åbne udtryk med
variable. Den fungerer dog lidt anderledes. I stedet for at ALLE cases, der
bliver beskrevet af kvantoren, skal være sande, behøver der blot at være én sand
case ved eksistenskvantoren. Det er lidt ligesom en disjunktion imellem alle
udtryk:

$ Q(1) or Q(2) or Q(3) or ... $
$ arrow.t.b.double $
$ exists x in ZZ^+ : Q(x) $

De individuelle elementer kan læses som:
- $exists$: der eksisterer
- $ZZ^+$: universet / domænet
- $:$ sådan at
- $2x > x$: udsagn

Sammensat: "Der eksisterer mindst ét $x$ i mængden af positive heltal sådan at
$Q(x)$ gælder".

Kvantorer har højere præcedens end de tidligere nævnte logiske operatorer.


== Negation af kvantorer
Kvantificerede udsagn kan også negeres.

Eksempel:

#figure(
  image("figures/quantifierneg.png", width: 80%),
  caption: [Negation af en allekvantor svarer til en eksistenskvantor over det
    negerede udsagn (og omvendt).],
)

- $not forall x in S : P(x)$ = "Det er ikke alle, blandt mængden af deltagere i
  SE4-DMAD, der deltager i denne forelæsning."
- $exists x in S : not P(x)$ = "Der findes mindst én, blandt mængden af deltagere
  i SE4-DMAD, der ikke deltager i denne forelæsning."
- $not exists x in S : P(x)$ = "Der findes ikke én, blandt mængden af deltagere i
  SE4-DMAD, der deltager i denne forelæsning."
- $forall x in S : not P(x)$ = "For alle, blandt mængden af deltagere i SE4-DMAD,
  deltager de ikke i denne forelæsning."

#figure(
  image("figures/quantifierneg2.png", width: 55%),
  caption: [Negationen skubbes ind forbi kvantoren, som samtidig skifter type.],
)

Denne negering er også det samme som De Morgans lov, påført på kvantorer:

#figure(
  image("figures/quantifierdemorgan.png", width: 65%),
  caption: [De Morgans love for kvantorer.],
)


== Indlejrede kvantorer
Et åbent udsagn kan have mere end én fri variabel.

Eksempel:

$ P(x, y): x + y = 0 $

- $P(2, -2)$ — Sandt
- $P(2, 0)$ — Falsk

En problemstilling som denne kan beskrives med indlejrede kvantorer:

$ forall x in ZZ : exists y in ZZ : x + y = 0 $

Det kan læses som: "For alle $x$, find mindst ét $y$, hvor udtrykket $x + y = 0$
er sandt."

Rækkefølgen på hvordan kvantorerne bliver indlejret har betydning. Se for
eksempel det omvendte:

$ exists y in ZZ : forall x in ZZ : x + y = 0 $

Det kan læses som: "Der eksisterer et $y$, hvor alle $x$ opfylder udtrykket
$x + y = 0$."

Ved indlejrede kvantorer vil kvantor nummer to altid afhænge af kvantor nummer
et.

Eksempel på forskellige indlejrede kvantorer:

#figure(
  image("figures/nestedquantifierorder.png", width: 75%),
  caption: [Rækkefølgen betyder noget: $forall s : exists h$ ("alle deltagere
    har en hobby") er ikke det samme som $exists h : forall s$ ("der findes én
    hobby, som alle har").],
)

Hvis man til gengæld har med to ens kvantorer at gøre, må man gerne bytte om på
rækkefølgen. Eksempel:

#figure(
  image("figures/nestedquantifiersame.png", width: 80%),
  caption: [Når begge kvantorer er ens, må rækkefølgen byttes om — og de kan
    skrives sammen, fordi $x$ og $y$ har samme univers.],
)

Det er også muligt at negere indlejrede kvantorudsagn med De Morgans lov:

#figure(
  image("figures/nestedquantifierneg.png", width: 70%),
  caption: [Negationen skubbes lag for lag indad, og hver kvantor skifter type
    undervejs.],
)

Det der sker:
+ Negeringen på $exists$ bliver rykket et lag længere ind til $forall$. Idet det
  sker bliver $exists$ lavet om til $forall$ pga. De Morgans lov.
+ Den nye negering på $forall$ bliver nu rykket et lag længere ind til selve
  udsagnet. Her bliver $forall$ lavet om til $exists$ pga. De Morgans lov.
+ Eftersom negeringen nu ligger på selve udsagnet er negeringen af kvantorerne
  færdig.


== Eksamenstips og faldgruber
_Noter tilføjes._
