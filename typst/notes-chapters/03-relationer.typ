= Relationer
// Del A — Diskret Matematik · Rosen kap. 9


== Hvad er en relation?
Relationer beskriver sammenhæng mellem elementer i en eller flere mængder. Bruges
f.eks. i databaser. I dette kursus skal vi kun arbejde med binære relationer — det
vil sige kun relationer mellem to elementer og ikke flere.

For to mængder $A$ og $B$ er en relation fra $A$ til $B$ en delmængde af
$A times B$, hvor $times$ er det kartesiske produkt.

F.eks.: hvis $A = {1, 2}$ og $B = {x, y}$, så er

$ A times B = {(1,x), (1,y), (2,x), (2,y)} $

En relation $R$ fra $A$ til $B$ er så en vilkårlig delmængde af dette kartesiske
produkt — altså bare nogle udvalgte par, f.eks.:

$ R = {(1,x), (2,y)} $

Det er også muligt at begge mængder brugt i det kartesiske produkt er den samme
mængde:

$ A = {1, 2, 3, 4} $

$ A times A = {& (1,1), (1,2), (1,3), (1,4), \
  & (2,1), (2,2), (2,3), (2,4), \
  & (3,1), (3,2), (3,3), (3,4), \
  & (4,1), (4,2), (4,3), (4,4) } $

Man kan desuden lave begrænsninger på mængderne der indgår i en given relation:

$ A = {1, 2, 3, 4} $
$ R_< = {(a,b) in A times A | a < b} = {(1,2), (1,3), (1,4), (2,3), (2,4), (3,4)} $


== Repræsentation
Der er forskellige måder at repræsentere en relation på:
- Mængde-notation (som dækket tidligere)
- Grafer
- Matricer

N.B.: Grafer og matricer kræver at vi benytter os af endelige mængder.

Eksempel på en mængde $A$, dens relation og hvordan den repræsenteres som
henholdsvis en matrix og en graf:

#figure(
  image("figures/relationrepresentation.png", width: 75%),
  caption: [Relationen $R_< = {(a,b) | a < b}$ på $A = {1, 2, 3, 4}$
    repræsenteret som matrix og som rettet graf.],
)


== Egenskaber
En relation kan have forskellige egenskaber:

- *Refleksiv*
  - En relation er refleksiv hvis alle elementerne relaterer til sig selv:
    $(1,1), (2,2), (3,3), (4,4)$ osv.
  - På grafnotation er det vist ved at hvert punkt har et loop tilbage til sig
    selv.
  - På matrixnotation skal der være 1-taller på diagonalen (positionerne nævnt
    ovenfor).
- *Symmetrisk*
  - En relation er symmetrisk hvis relationen for $(a,b)$ også gælder det
    omvendte $(b,a)$.
  - På grafnotation er der pile hver vej mellem to elementer.
  - På matrixnotation er matricen symmetrisk om diagonalen.
- *Antisymmetrisk*
  - En relation er antisymmetrisk hvis der for alle par af forskellige elementer
    $a$ og $b$ gælder at $(a,b)$ og $(b,a)$ ikke eksisterer samtidig. Altså
    retningen på relationen må kun gå én vej.
  - På grafnotation må der aldrig være dobbeltpil mellem to forskellige punkter.
  - På matrixnotation må man ikke have symmetrisk placerede 1-taller på tværs af
    diagonalen.
- *Transitiv*
  - En relation er transitiv hvis man for alle elementer altid kan "hoppe
    igennem" et mellemled, givet at en kæde af relationer ellers ville føre
    dertil. Altså hvis $(a,b)$ og $(b,c)$, så $(a,c)$.
  - På grafnotation må der være en pil fra $a$ til $c$ hvis der i forvejen er
    pilene $a$ til $b$ og $b$ til $c$.
  - På matrixnotation skal man tjekke alle kombinationer: for hver 1'er i
    $(a,b)$ og hver 1'er i $(b,c)$ skal der også være en 1'er i $(a,c)$.


== Ækvivalensrelationer
En relation betegnes som en ækvivalensrelation hvis den er refleksiv, symmetrisk
og transitiv på samme tid. Hvis $R$ er en ækvivalensrelation og $(a,b) in R$,
kaldes $a$ og $b$ ækvivalente.

Hvis $R$ er en ækvivalensrelation på $A$, og $a in A$, da er $a$'s
ækvivalensklasse:

$ [a]_R = {b | (a,b) in R} $

Altså: ækvivalensrelationen er en måde at gruppere elementer der er det samme på
en bestemt måde, f.eks. lige eller ulige tal. Ækvivalensklassen $[a]_R$ er så den
gruppe som $a$ tilhører — altså den mængde af $b$-elementer som $a$ relaterer sig
til.

#figure(
  image("figures/equivalentrelation.png", width: 60%),
  caption: [Ækvivalensrelationen $a equiv b$ (mod 3) på $NN$ deler mængden i tre
    ækvivalensklasser $[0]_R, [1]_R, [2]_R$ — en partition af $NN$. På billedet
    betyder "mod" modulus.],
)

=== Sætninger for ækvivalensklasser og partitionering
For enhver mængde $A$ gælder:
+ For enhver ækvivalensrelation $R$ på $A$ udgør $A$'s ækvivalensklasser en
  partitionering af $A$ (en disjunkt opdeling).
+ Omvendt: for enhver partitionering $P$ af $A$ findes der en ækvivalensrelation
  $R$ på $A$, sådan at mængderne i $P$ netop er $R$'s ækvivalensklasser.

Disse udtryk betyder at ækvivalensrelationer og partitioner er to sider af samme
mønt — enhver ækvivalensrelation giver en partition, og enhver partition kommer
fra en ækvivalensrelation.


== Partielle ordninger
Hvis en relation $R$ på en mængde $A$ er refleksiv, antisymmetrisk og transitiv
på samme tid, kaldes den en partiel ordning. Navnet "ordning" giver intuitivt
mening, da det handler om at rangere elementer, og det kan man kun hvis man ikke
har begge retninger på samme tid (som symmetri ville tillade).

Her kan en partiel ordning ses:

#figure(
  image("figures/potes.png", width: 80%),
  caption: [Delelighedsrelationen $R = {(a,b) | a divides b}$ på
    ${1,2,3,4,5,6}$. De røde loops følger af refleksivitet, og de blå pile følger
    af transitivitet.],
)

Man kan også simplificere sådanne grafer og i stedet lave et Hasse-diagram:

#figure(
  image("figures/hassediagram.png", width: 55%),
  caption: [Hasse-diagram for samme delelighedsrelation.],
)

- Udelad alle loops og "genveje" der følger af kæder.
- Tegn kun $a$ under $b$ hvis $a$ er relateret til $b$ via relationen $R$ (ingen
  pile nødvendige — placeringen viser retningen).

=== Flere definitioner
Flere definitioner for partielle ordninger:

#figure(
  image("figures/potesdefinitions.png", width: 75%),
  caption: [Sammenlignelige elementer (Def. 9.6.2) og total ordning (Def. 9.6.3):
    en partiel ordning hvor _alle_ par er sammenlignelige.],
)

=== Leksikografisk ordning
Introducerer hvordan man kan kombinere to partielle ordninger $succ.eq_1$,
$succ.eq_2$ til en ny ordning på par $(a_1, a_2)$:

$ (a_1, a_2) prec (b_1, b_2) quad "hvis" quad a_1 prec_1 b_1 quad "eller" quad (a_1 = b_1 "og" a_2 prec_2 b_2) $

Sagt med ord: man sammenligner først koordinaten $a_1$ med $b_1$. Hvis de er
forskellige, afgør det rækkefølgen. Hvis de er ens, går man videre og
sammenligner den anden koordinat.

Eksempel:

#figure(
  image("figures/leksikographic.png", width: 45%),
  caption: [Leksikografisk sammenligning af koordinatsæt.],
)


== Lukninger
Man kan sørge for at en relation opfylder en bestemt egenskab ved at bruge
lukninger:

- *Refleksiv lukning* — tilføj præcis de manglende refleksive par der skal til
  for at hele relationen er refleksiv.
- *Symmetrisk lukning* — tilføj præcis de manglende symmetriske par der skal til
  for at hele relationen er symmetrisk.
- *Antisymmetrisk lukning* — eksisterer ikke.
- *Transitiv lukning* — tilføj præcis de manglende transitive par der skal til
  for at hele relationen er transitiv. Altså tilføj de "genveje" der skal til for
  at enhver sti i grafen bliver til en direkte kant.


== Eksamenstips og faldgruber

=== Transitiv lukning: husk de originale par
*Definition.* Den transitive lukning af en relation $R$ er den MINDSTE transitive
relation der INDEHOLDER $R$. Det betyder at svaret altid er hele den udvidede
mængde — de ORIGINALE par PLUS de NYE par der skal tilføjes for at gøre relationen
transitiv. Det er IKKE kun de nye/manglende par.

*VIGTIG FALDGRUBE.* Når en opgave spørger "angiv den transitive lukning af
relationen $R$", skal svaret indeholde:
$ ("originale par i " R) union ("nye par der kræves for transitivitet") $
Det er en hyppig fejl kun at angive de NYE par man har udledt, og glemme at de
oprindelige par fra $R$ stadig skal være med i svaret.

Samme princip gælder for andre typer "lukning":
- *Refleksiv lukning:* original relation + alle par $(x, x)$ der mangler.
- *Symmetrisk lukning:* original relation + alle par $(y, x)$ hvor $(x, y)$ er der.
- *Transitiv lukning:* original relation + alle par der følger af transitivitet.

*Metoden til at finde nye par (transitivitet).* Transitivitet betyder: hvis
$(x, y)$ og $(y, z)$ begge er i relationen, skal $(x, z)$ også være med. Gå
systematisk igennem: for hvert par $(x, y)$ i relationen, tjek om der findes et
par $(y, z)$ (samme "mellem-element" $y$) — hvis ja, tilføj $(x, z)$. Gentag
processen også med NYE par der er tilføjet undervejs, indtil ingen flere nye par
kan udledes (fixpunkt).

*Eksempel.* Original relation: ${(a, b), (a, c), (b, b), (c, d), (d, e)}$.

Udled nye par:
- $(a, c)$ og $(c, d)$ → tilføj $(a, d)$.
- $(a, d)$ (nyt) og $(d, e)$ → tilføj $(a, e)$.
- $(c, d)$ og $(d, e)$ → tilføj $(c, e)$.
- $(b, b)$ og $(b, b)$ → giver intet nyt (allerede der).

Ingen flere nye par kan udledes. SVARET (fuld transitiv lukning, original + nye):
$ {(a, b), (a, c), (a, d), (a, e), (b, b), (c, d), (c, e), (d, e)} $
IKKE blot ${(a, d), (a, e), (c, e)}$ — det er kun tilføjelserne, ikke hele svaret.

*Tjekliste:*
+ List den originale relation.
+ Find alle nye par via transitivitets-reglen, gentag til fixpunkt.
+ SVARET $=$ original relation $union$ alle nye par (husk foreningsmængden!).
+ Dobbelttjek at originale par stadig er med i det endelige svar.
