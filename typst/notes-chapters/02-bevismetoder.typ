= Bevismetoder
// Del A — Diskret Matematik · Rosen kap. 1 + 5


== Direkte bevis
Hvis man kan bygge en kæde af implikationer fra $p$ til $q$ via mellemtrin
$p_1, p_2, ..., p_n$, så følger $p arrow.r.double q$ automatisk.

$ p arrow.r.double p_1 arrow.r.double p_2 arrow.r.double ... arrow.r.double p_n arrow.r.double q arrow.r.double (p arrow.r.double q) $

Det er den mest ligetil bevistype. Man starter med en antagelse $p$ og slutter
sig logisk frem til $q$.

Eksempel på et direkte bevis:

#figure(
  image("figures/directproofex.png", width: 70%),
  caption: [$n$ ulige $arrow.r.double n^2$ ulige (Eks. 1.7.1). Kæden af
    ækvivalenser og implikationer fører fra $p$ til $q$.],
)


== Kontrapositionsbevis
Her udnytter vi ækvivalensen:

$ p arrow.r.double q arrow.l.r.double (not q arrow.r.double not p) $

I stedet for direkte at bevise $p arrow.r.double q$, beviser man den logisk
ækvivalente kontraposition. Altså hvis $q$ er falsk, så må $p$ også være falsk.
Dette er nyttigt i de tilfælde, hvor det er lettere at arbejde med negationerne
end med de oprindelige udsagn.

Eksempel på et kontrapositionsbevis:

#figure(
  image("figures/contrapositionproof1.png", width: 75%),
  caption: [Eks. 1.7.9: for ethvert $n in ZZ$ gælder $n^2$ ulige
    $arrow.r.double n$ ulige.],
)

Det er svært at lave et direkte bevis for det ovenstående udtryk:

$ n^2 = 2k+1 arrow.r.double n = plus.minus sqrt(2k+1) arrow.r.double space ? ? $

Her kan det være smart at bruge et kontrapositionsbevis, da vi så kan arbejde med
$n$ i antagelsen og $n^2$ i konklusionen og derfra bare lave et direkte bevis:

#figure(
  image("figures/contrapositionproof2.png", width: 75%),
  caption: [I stedet bevises kontrapositionen $not (n "ulige") arrow.r.double not
    (n^2 "ulige")$, dvs. $n$ lige $arrow.r.double n^2$ lige, med et direkte
    bevis.],
)


== Modstridsbevis
Her udnytter vi ækvivalensen:

$ not p arrow.r.double F arrow.l.r.double p $

Vi kan bevise $p$ ved at vise, at det modsatte $not p$ resulterer i en modstrid.
Da $not p arrow.r.double F$ er sandt, må $not p$ være falsk og dermed må $p$ være
sand.

Eksempel på et modstridsbevis:

#figure(
  image("figures/contradictionproof.png", width: 70%),
  caption: [Antag til modstrid det omvendte $c >= a+b$, og udled en modstrid.],
)

Her beviser vi at udsagnet $c < a+b$ er sandt ved at finde en modstrid til det
omvendte: $c >= a+b$. Modstriden er Pythagoras.


== Tricks til bevismetoder
Man kan splitte op i delresultater, når man skal bevise en biimplikation. Ved at
splitte biimplikationen op kan man i stedet bevise to separate implikationer.

#figure(
  image("figures/trick1.png", width: 80%),
  caption: [En biimplikation $p arrow.l.r.double q$ kan splittes i $p
    arrow.r.double q$ og $q arrow.r.double p$ — eller en kæde af biimplikationer
    i en cyklus af implikationer.],
)

Et andet trick er, at man kan dele et problem op i specialtilfælde, som dækker
alle muligheder, og bevise hvert tilfælde separat.

#figure(
  image("figures/trick2.png", width: 70%),
  caption: [Del op i specialtilfælde der dækker alle muligheder; her efter om $n$
    er lige eller ulige. ($floor(x)$ runder ned, $ceil(x)$ runder op.)],
)

Dette eksempel deler op baseret på om $n$ er lige eller ulige.


== Terminologi
- *Sætning:* Et vigtigt udsagn, som er bevist til at være sandt.
- *Lemma:* En hjælpesætning, som bruges til at strukturere et langt bevis.
- *Korollar:* En følgesætning, som er et udsagn der følger umiddelbart af en
  sætning.


== Induktionsbevis
Induktionsbeviser bruges til at bevise parametriserede udsagn. De bruges ofte til
at vise korrekthed af iterative eller rekursive algoritmer. Et induktionsbevis
bruger et basistilfælde, som beviser at et udsagn passer. Derefter bruges et
induktionsskridt til at bevise, at alle efterfølgende udsagn også passer. På den
måde minder det lidt om dominoeffekten: vi viser at første brik kan væltes,
hvorefter vi viser at brikkerne står tæt nok til, at alle de følgende brikker
også vælter.

Eksempel:

#figure(
  image("figures/inductionproof1.png", width: 65%),
  caption: [Opbygning af et induktionsbevis for $2^n < n!$ for alle heltal
    $n >= 4$: basistilfældet og idéen bag induktionsskridtet.],
)

#figure(
  image("figures/inductionproof2.png", width: 75%),
  caption: [Det færdige induktionsbevis: basis ($n = 4$) og induktionsskridt,
    hvor der ganges med $2$ på begge sider af uligheden.],
)

Det er ikke nødvendigt at opbygge induktionsskridtet som et direkte bevis, hvor
hele kæden skal vises. Man kan i stedet tage udgangspunkt i venstresiden af den
ulighed der skal udledes, og så bruge induktionsantagelsen undervejs.

For at udlede $2^n < n!$ kan vi med fordel opsætte induktionsantagelsen:

$ 2^k < k! $

Vi vil bevise induktionsskridtet:

$ 2^(k+1) < (k+1)! $

Først omskrives der med en potensregneregel:

$ 2^(k+1) = 2 dot 2^k $

Brug induktionsantagelsen til at udskifte $2^k$:

$ 2 dot 2^k < 2 dot k! $

Eftersom $2 < k+1$ kan $2$ nu udskiftes:

$ 2 dot k! < (k+1) dot k! $

Benyt faktorial-reglen til at samle udtrykket:

$ (k+1) dot k! = (k+1)! $

Dermed:

$ 2^(k+1) < (k+1)! $


== Eksamenstips og faldgruber
_Noter tilføjes._
