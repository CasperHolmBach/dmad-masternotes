= Rekursionsligninger
// Del B — Algoritmer og Datastrukturer · slides: divideAndConquer*, strassen


== Divide and conquer
Divide and conquer er en algoritme-udviklingsmetode, som er rekursiv. Filosofien
bag divide and conquer går ud på:
- Opdel problemet i mindre delproblemer.
- Løs delproblemerne ved rekursion. Kalder sig selv med det mindre delproblem
  som input.
- Konstruer en løsning til problemet ud fra løsningen af delproblemerne.

Ligesom enhver anden rekursiv algoritme, skal en divide and conquer algoritme
også have et basistilfælde, så den ikke kører uendeligt. For divide and conquer
betyder det at et problem af mindste størrelse løses direkte uden at benytte
rekursion.

En generel struktur af en divide and conquer algoritme kunne se sådan her ud:

#figure(
  image("figures/generaldivideandconquer.png", width: 75%),
  caption: [Generel struktur af en divide and conquer algoritme.],
)

Arbejdsflowet for en divide and conquer algoritme kan vises således:

#figure(
  image("figures/divideandconquerworkflow.png", width: 75%),
  caption: [Arbejdsflow for en divide and conquer algoritme.],
)

Hvor:
- En knude (oval, firkant) er ét kald af algoritmen.
- En blå prik er lokalt arbejde udført.
- En rød linje er selve det rekursive kald.

=== Eksempler på divide and conquer algoritmer
*Mergesort:*
+ Del input op i to dele $X$ og $Y$.
+ Sorter hver del for sig med rekursion.
+ Merge de to sorterede dele til én sorteret del.

Basistilfælde: $n <= 1$.

*Quicksort:*
+ Del input op i to dele $X$ og $Y$ så $X <= Y$.
+ Sorter hver del for sig.
+ Returner $X$ efterfulgt af $Y$.

Basistilfælde: $n <= 1$.


== Rekursionsligning
Køretiden for en rekursiv algoritme kan beskrives ved en rekursionsligning:

#figure(
  image("figures/recursionfunction.png", width: 70%),
  caption: [Generel form af en rekursionsligning.],
)

Hvor:
- $a$ = Hvor mange rekursive kald algoritmen laver.
- $b$ = Hvor meget mindre hvert delproblem bliver (f.eks. halveres → $b = 2$).
- $f(n)$ = Hvor meget lokalt arbejde algoritmen laver.
- $Theta(1)$ = Basistilfældet.

Ofte undlader man at skrive basistilfældet med, fordi det altid er det samme.

*Eksempel (Mergesort):*
$ T(n) = 2T(n/2) + n $
Mergesort laver 2 rekursive kald: $a = 2$, og hvert kald halverer inputtet:
$b = 2$. Til sidst laver den $Theta(n)$ lokalt arbejde (når der flettes sammen
igen).


== Rekursionstræ-metoden
Rekursionstræsmetoden er en opskrift på, hvordan man finder den samlede køretid
$T(n)$ ud fra et rekursionstræ.

*Trin 1: Annotér hver knude i træet.* \
For hver knude (hvert kald), skriv:
- Input-størrelse ($n$, $n/2$, $n/4$).
- Arbejdet udført i den knude ($f(n)$, $f(n/2)$).

*Trin 2: Find den samlede køretid.* \
Det gøres i tre skridt:
+ Find træets højde.
+ Sum arbejdet i hvert lag for sig.
+ Sum alle lagene sammen.

#figure(
  image("figures/recursiontreeexample.png", width: 55%),
  caption: [Eksempel: $T(n) = 2T(n/2) + n$.],
)

#figure(
  image("figures/recursiontreeexample2.png", width: 55%),
  caption: [Eksempel 2: $T(n) = 3T(n/2) + n$.],
)

#figure(
  image("figures/recursiontreeexample3.png", width: 55%),
  caption: [Eksempel 3: $T(n) = 3T(n/4) + n^2$.],
)

Når man regner rekursionstræmetoden bruger man den geometriske sum:
$ 1 + c + c^2 + c^3 + ... + c^k = (c^(k+1) - 1)/(c - 1) = Theta(c^k) $
Læg mærke til at summen er $Theta(c^k)$. Det vil sige at den vokser asymptotisk
lige så hurtigt som det største led i summen, her $c^k$.

Eftersom vi benytter asymptotisk notation, er det irrelevant hvilken base vores
logaritme har, da de alle er en konstant faktor fra hinanden. Derfor:
$ log_b x = Theta(log_c x) $


== Master-sætningen (CLRS 4. udgave)
Master theorem er en "genvejs-tabel" til at finde løsningen på en
rekursionsligning der står på formen:
$ T(n) = a dot T(n/b) + f(n) $
På den måde kan man undgå at skulle tegne rekursionstræet og summere lagene.

$alpha = log_b a$ er det punkt, hvor $f(n)$ "matcher" rekursionens egen vækst.
$n^alpha$ er den vækstrate du ville få hvis algoritmen ikke lavede noget lokalt
arbejde overhovedet. Det fungerer som en neutral baseline som $f(n)$ bliver
sammenlignet med.

Der er 3 forskellige cases man kan være i, hvorfra man kan aflæse sit svar
direkte:

*Case 1:* $f(n)$ er polynomielt mindre end $n^alpha$.
- Formelt: $f(n) = O(n^(alpha - epsilon))$ for et $epsilon > 0$.
- $T(n) = Theta(n^alpha)$.
- Det lokale arbejde er ubetydeligt. Rekursionen selv dominerer køretiden.

*Case 2:* $f(n)$ er (cirka) lige stor som $n^alpha$.
- Formelt: $f(n) = Theta(n^alpha log^k n)$ for et $k >= 0$.
- $T(n) = Theta(n^alpha log^(k+1) n)$.
- De to vækstrater matcher hinanden og resultatet bliver det samme, men med en
  ekstra log-faktor.

*Case 3:* $f(n)$ er polynomielt større end $n^alpha$.
- Formelt: $f(n) = Omega(n^(alpha + epsilon))$ for et $epsilon > 0$.
- $T(n) = Theta(f(n))$.
- Det lokale arbejde dominerer så meget, at hele køretiden bare bliver lig med
  arbejdet ved roden.
- Der er en ekstra betingelse ved case 3. Det skal også gælde at:
  $a dot f(n/b) <= c dot f(n)$, for en konstant $c < 1$.
- Det sikrer at $f(n)$ ikke hopper vildt op og ned og vokser jævnt. I praksis er
  denne betingelse næsten altid opfyldt.

Kort sagt: case afgøres af forholdet mellem voksehastighederne for $f(n)$ og for
$n^alpha log^k n$ hvor $k >= 0$.
- Er $f(n)$ mindre med mindst en faktor $n^epsilon$ har vi case 1.
- Er de ens har vi case 2.
- Er $f(n)$ større med mindst en faktor $n^epsilon$ har vi case 3.

=== Master theorem anvendt på de tre Mergesort-eksempler
*Eksempel 1:*
#figure(
  image("figures/recursiontreeexample.png", width: 50%),
  caption: [$T(n) = 2T(n/2) + n$.],
)
Master theorem:
#figure(
  image("figures/masterex1.png", width: 75%),
  caption: [Master theorem på eksempel 1.],
)

*Eksempel 2:*
#figure(
  image("figures/recursiontreeexample2.png", width: 50%),
  caption: [$T(n) = 3T(n/2) + n$.],
)
Master theorem:
#figure(
  image("figures/masterex2.png", width: 75%),
  caption: [Master theorem på eksempel 2.],
)

*Eksempel 3:*
#figure(
  image("figures/recursiontreeexample3.png", width: 50%),
  caption: [$T(n) = 3T(n/4) + n^2$.],
)
Master theorem:
#figure(
  image("figures/masterex3.png", width: 75%),
  caption: [Master theorem på eksempel 3.],
)

=== Når master theorem ikke kan anvendes
Der er nogle rekursionsligninger hvor master theorem ikke kan bruges. Et
eksempel kan være:
$ T(n) = T(n/3) + T(2n/3) + n $
Master theorem kræver at alle rekursive kald $n/b$ er lige store, hvilket de i
det her tilfælde ikke er. Dette er også et asymmetrisk træ. I sådanne tilfælde
bliver man nødt til at benytte sig af rekursionstræmetoden.

=== Ulige input (afrunding)
Vi kan komme ud for et scenarie, hvor inputtet $n$ er et ulige tal. Dette giver
os to rekursive kald hvor inputtet ikke kan deles lige op. For at komme uden om
det deler vi i en halvdel der er rundet op $ceil(n/2)$, og en anden halvdel der
er rundet ned $floor(n/2)$.

Som eksempel går Mergesort fra:
$ T(n) = 2 dot T(n/2) + n $
Til:
$ T(n) = T(ceil(n/2)) + T(floor(n/2)) + n $
Dette gør ingen forskel for beregningen af køretiden.


== Matrixmultiplikation
En matrix er en firkant af tal:

#figure(
  image("figures/matrix.png", width: 30%),
  caption: [En matrix.],
)

Alle matricer er $n times n$ kvadratiske. Den ovenstående er $3 times 3$.

Addition for matricer sker som følgende:

#figure(
  image("figures/matrixaddition.png", width: 60%),
  caption: [Addition af to matricer.],
)

Addition af matricer har køretid: $Theta(n^2)$.

Gange for matricer sker som følgende:

#figure(
  image("figures/matrixmultiply.png", width: 60%),
  caption: [Multiplikation af to matricer.],
)

Multiplikation af matricer har køretid: $Theta(n^3)$ — kan det gøres bedre? Ikke
med en rekursiv algoritme. Den giver samme køretid, hvilket master theorem
afspejler:

#figure(
  image("figures/matrixmultiplicationmt.png", width: 70%),
  caption: [Master theorem på den rekursive matrixmultiplikation: $Theta(n^3)$.],
)

=== Strassens algoritme
Vi kan med fordel bruge Strassen algoritmen for at få en bedre køretid.

Først beregner vi 10 hjælpematricer:

#figure(
  image("figures/helpmatrix.png", width: 60%),
  caption: [De 10 hjælpematricer.],
)

De bruges til at finde kun 7 produkter frem for de før 8. Det er vores rekursive
kald:

#figure(
  image("figures/strassenproducts.png", width: 60%),
  caption: [De 7 produkter (de rekursive kald).],
)

Til sidst kan de fire værdier findes i $2 times 2$ matrixen:

#figure(
  image("figures/strassensecondlast.png", width: 60%),
  caption: [De fire værdier i resultatmatrixen.],
)

#figure(
  image("figures/strassenlast.png", width: 60%),
  caption: [Resultatmatrixen.],
)

Ved hjælp af master theorem kan vi nu vurdere den nye køretid når Strassen
algoritmen benyttes:

#figure(
  image("figures/strassenmt.png", width: 70%),
  caption: [Master theorem på Strassens algoritme.],
)


== Eksamenstips og faldgruber
_Noter tilføjes._
