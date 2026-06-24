= Søgetræer
// Del B — Algoritmer og Datastrukturer · slides: dictionarySlides, augmentedBSTSlides


== Dictionaries
En datastruktur, som tilbyder følgende operationer:
- *Search(key):* Returnerer elementet med nøglen key, eller fortæller hvis det ikke findes.
- *Insert(key):* Indsætter et nyt element med nøglen key.
- *Delete(key):* Fjerner elementet med nøglen key.
- *Predecessor(key):* Finder elementet med højeste nøgle $<$ key. Nøglen der kommer lige før key (i sorteret rækkefølge).
- *Successor(key):* Finder elementet med laveste nøgle $>$ key. Nøglen der kommer lige efter key (i sorteret rækkefølge).
- *OrderedTraversal():* Udskriver elementer i sorteret orden.

Hvis kun de tre første metoder understøttes kaldes det for et unordered dictionary.
Hvis alle seks metoder understøttes, kaldes det for et ordered dictionary.


== Binære søgetræer
Et binært træ, hvor knuderne er i "inorder". Træet er inorder hvis det for alle
knuder $v$ gælder:

#align(center)[nøgler i $v$'s venstre undertræ $<=$ nøgle i $v$ $<=$ nøgler i $v$'s højre undertræ]

#figure(
  image("figures/inorderbinarytrees.png", width: 70%),
  caption: [To binære søgetræer over samme nøgler — inorder-egenskaben er opfyldt i begge.],
)

Pga. definitionen af inorder, kan det siges at binære søgetræer indeholder data i
sorteret orden. Derfor vil et inorder gennemløb udskrive nøgler i sorteret orden.

#figure(
  image("figures/inordertreewalk.png", width: 45%),
  caption: [`INORDER-TREE-WALK`: venstre undertræ, knude, højre undertræ.],
)

Denne funktion har en lineær køretid $O(n)$.


=== Søgning i binære træer
Et normalt tree-search fungerer ved at bevæge sig til venstre, hvis det efterspurgte
tal er mindre end den nuværende knudes nøgle. Hvis det efterspurgte tal er højere,
bevæger man sig til højre i stedet.

#figure(
  image("figures/treesearch.png", width: 50%),
  caption: [`TREE-SEARCH`: gå venstre når $k <$ key, ellers højre.],
)

Det er nemt at finde enten minimum eller maksimum i et binært søgetræ:
- *Minimum:* bevæg sig til venstre til man ikke kan mere
- *Maksimum:* bevæg sig til højre til man ikke kan mere

#figure(
  image("figures/binarytreeminmax.png", width: 55%),
  caption: [`TREE-MINIMUM` / `TREE-MAXIMUM`: følg venstre- hhv. højre-kæden ud.],
)

Man kan finde en nøgles successor ved:
- Hvis knuden $v$ har et højre barn – find mindste nøgle i knuden $v$'s højre undertræ. Altså gå højre, og så helt til venstre.
- Hvis knuden $v$ ikke har et højre barn – find nærmeste forfader, hvor jeg ankommer fra venstre side. Den forfader er successoren.


=== Indsættelse i binære søgetræer
Man søger ned fra roden, indtil man rammer et tomt blad (NIL blad). Her indsætter man
den nye knude. Resten af træet er upåvirket, så inorder bevares automatisk.


=== Sletning i binære søgetræer
Når man sletter en værdi i et binært søgetræ, er der to cases at tage hensyn til:
- Knuden har mindst ét tomt barn → fjern knuden, og sæt barnet i dens sted.
- Knuden har to børn → find dens successor (mindste i højre undertræ), kopiér dens værdi op, og slet successoren (der lige er blevet kopieret) i stedet.

#figure(
  image("figures/binarytreedeletion.png", width: 75%),
  caption: [Sletning i et binært søgetræ — de forskellige cases.],
)


=== Køretider for operationer på binære søgetræer
Alle operationer tager tid proportional med højden af træet. Et fyldt træ med $n$
knuder har bedst mulig højde på $log(n)$, men et skævt træ kan have højde op til $n$.
Det er derfor vigtigt at undgå ubalancerede søgetræer.


== Balancerede binære søgetræer (rød-sorte træer)
For at holde højden $O(log n)$ under indsættelser og sletninger bliver vi nødt til at
rebalancere træet. I dette kursus benytter vi rød-sorte træer som teknik til at holde
$log n$ højde.

Med rød-sorte træer opstiller vi tre krav:
- Rod og blade er sorte
- Samme antal sorte knuder på alle stier fra rod til blad
- Aldrig to røde knuder i træk

#figure(
  image("figures/redblacktree.png", width: 90%),
  caption: [Et rød-sort træ. Tallene ved kanterne angiver sort-højden.],
)

Normalt er bladet på et træ det sidste lag, som ikke har nogle børn. På rød-sorte
træer tilføjer man et ekstra lag knuder, som kaldes NIL knuder. Det er de nye blade,
selvom det er tomme / ikke eksisterende knuder.

Pga. reglen om samme antal sorte knuder for alle stier garanterer vi, at højden er
logaritmisk.


=== Indsættelse og rotationer
Man indsætter i et rød-sort træ ligesom et normalt binært søgetræ. Her erstatter vi
et NIL blad med den nye værdi, og den nye knude skal farves rød. Opstår der en
rød-rød konflikt skubber vi problemet op igennem træet ved på skiftevis at omfarve
knuderne. Kan konflikten ikke løses ved simpel omfarvning, må vi restrukturere træet.
Det gør vi ved hjælp af en rotation, som beholder inorder.

#figure(
  image("figures/redblacktreerotation.png", width: 65%),
  caption: [`LEFT-ROTATE`: en rotation ændrer strukturen men bevarer inorder.],
)

Rebalancering kan generelt deles op i to cases:
- *Rød onkel* – konflikt løses ved simpel omfarvning
- *Sort onkel* – konflikt løses ved både omfarvning og rotation

Onkel = $y$ på figurer.

#figure(
  image("figures/rebalancecase1.png", width: 70%),
  caption: [Rød onkel: konflikten løses ved omfarvning alene.],
)

#figure(
  image("figures/rebalancecase2.png", width: 60%),
  caption: [Sort onkel: konflikten kræver omfarvning og rotation (Case 2 → Case 3).],
)


=== Sletning
Man sletter en knude i et rød-sort træ, ligesom man ville gøre i et normalt binært
træ (kopiér successor over på knude, og så slet successor i stedet). Nu skal vi bare
holde øje med om vi bryder nogle rød-sort krav. Der er to cases:
- *Fjernet knude var rød:* alle rød-sort krav er stadig overholdt
- *Fjernet knude var sort:* ikke længere samme antal sorte på stier

Fjerner man en sort knude kan man med fordel bruge "sværtning" til at genoprette
inorder. Knuden, der tager den fjernede knudes plads, kaldes sværtet. Den tæller nu
for "én ekstra sort" end sin faktiske farve:
- Sværtet sort knude = tæller som 2 sorte
- Sværtet rød knude = tæller som 1 sort (som en normal sort knude)

Med dette trick er reglerne kunstigt genoprettet. Der er nu blot én "ugyldig" sværtet
knude i træet, som skal fjernes via rebalancering.

Stop-tilfælde (nemme):
- Sværtet knude er rød → farv den sort. Færdig.
- Sværtet knude er roden → fjern bare sværtningen (alle stier mister én sort samtidig, reglen holder stadig).

Svært tilfælde:

Sværtet knude er sort (og ikke rod) → brug omfarvning/rotation (4 cases, afhænger af
søskendeknudens ($w$) farve og dens børns farver) til at fjerne sværtningen eller
skubbe den ét niveau op mod roden.
- Rød søsken
- Sort søsken, og denne har to sorte børn
- Sort søsken, og dennes nærmeste barn er rødt, det fjerneste sort
- Sort søsken, og dennes fjerneste barn er rødt

#figure(
  image("figures/redblackfourcases.png", width: 70%),
  caption: [De fire cases ved sletning i et rød-sort træ.],
)


== Udvidede (augmented) træer
Binære søgetræer med ekstra information i knuderne. Et eksempel kunne være, at alle
knuder gemmer størrelsen af deres undertræ (antal af knuder i undertræ inklusiv sig
selv):

#figure(
  image("figures/augmentedbst.png", width: 90%),
  caption: [Et rød-sort træ hvor hver knude gemmer sin nøgle (key) og sin undertræ-størrelse (size).],
)

Ekstra information kan give os mulighed for at tilføje ny funktionalitet til et
binært søgetræ. F.eks. ved at gemme størrelse kan vi udføre følgende to nye
operationer i $O(log n)$ tid:
- *OS-Rank:* Find rang af en given nøgle. Altså nøglens "plads-nummer", hvis alle nøgler stod i sorteret rækkefølge.
- *OS-Select:* Find nøgle der har en given rang.

#figure(
  image("figures/augmentedbstrank.png", width: 90%),
  caption: [Rang = nøglens nummer i sorteret orden.],
)

Pseudokoden ser sådan ud:

#figure(
  image("figures/augmentedbstfunctionspseudo.png", width: 85%),
  caption: [`OS-RANK` og `OS-SELECT`.],
)

Man skal huske at vedligeholde den ekstra information, når der forekommer
indsættelser, sletninger eller rotationer. Det er heldigvis nemt når man tager
følgende i betragtning:
- Hvis en knudes to børns værdier $k_1$ og $k_2$ er korrekt, kan knudens egen værdi $k$ beregnes i $O(1)$ tid. Et blads værdi kan beregnes i $O(1)$ tid.

For eksemplet der bruger undertræs-størrelse som ekstra information kan en given knude
opdateres ved $k = 1 + k_1 + k_2$.

Dette princip gælder for alle slags ekstra informationer, og ikke blot størrelse af
undertræer.


== Eksamenstips og faldgruber

=== Rød-sort træ: indsættelse og fixup
*Trin 1 — almindelig BST-indsættelse.* Indsæt nøglen som man ville i et
almindeligt binært søgetræ (ignorer farver et øjeblik). Den nye knude z farves
altid RØD ved indsættelse, og dens to børn er NIL (sorte, blade).

*Trin 2 — tjek for rød-rød konflikt.* Hvis den nye knudes forælder ALLEREDE er
rød, har vi en rød-rød konflikt (to røde knuder i forælder-barn-relation), som
bryder rød-sort-reglerne. Dette kræver en "fixup". Hvis forælderen er SORT, er der
ingen konflikt — indsættelsen er færdig, ingen yderligere ændring nødvendig.

*Fixup-casene (når z og z.parent begge er røde).* Lad z = den nye/aktuelle knude,
og lad "bedsteforælder" = z.parent.parent. Find "onkel" = bedsteforælderens andet
barn (modsat side af z.parent).

*Case 1 — onkel er RØD:*
- Farv forælder og onkel SORT.
- Farv bedsteforælder RØD.
- Sæt z = bedsteforælder, og fortsæt fixup opad fra der (loop igen).

*Case 2 + 3 — onkel er SORT (eller NIL):* Her skal vi se på om z og z.parent
ligger på "samme side" eller "modsatte sider" af bedsteforælderen:
- *Samme side* (f.eks. z er venstre barn, z.parent er også venstre barn af bedsteforælder — "left-left", eller "right-right"):
  - Farv z.parent SORT, bedsteforælder RØD.
  - Rotér bedsteforælder (rotation modsat den side z.parent ligger på: left-left → højre-rotation om bedsteforælder).
- *Modsatte sider* (f.eks. z er venstre barn, men z.parent er HØJRE barn af bedsteforælder — "right-left", eller omvendt "left-right"):
  - Først: rotér z.parent (i den retning der "retter ud" knækket, f.eks. højre-rotation hvis det er right-left-tilfældet).
  - Sæt z = den gamle z.parent (nu flyttet til at være barn).
  - Derefter udfør samme handling som "samme side"-tilfældet: farv z.parent sort, bedsteforælder rød, og rotér bedsteforælder.

*VIGTIGT — rod-farven.* Til sidst sættes roden af træet altid til SORT (uanset
hvad fixup-loopet ellers har gjort) — dette er en garanti i algoritmen, ikke noget
man skal udlede.

*Eksempel (fra opgaven).* Indsæt 21 i træet, hvor 21 BST-indsættes som venstre
barn af 23 (rød).
- z = 21 (rød), z.parent = 23 (rød) → rød-rød konflikt.
- z.parent.parent = 20. Er 23 venstre eller højre barn af 20? HØJRE.
- Er 21 (z) venstre eller højre barn af 23? VENSTRE.
- Det er "right-left"-tilfældet (modsatte sider).
- Onkel (20's andet barn, dvs. 20's VENSTRE barn) er NIL (sort) → bekræfter at vi er i case 2/3, ikke case 1.

Udførelse:
+ Højre-rotation om 23 (retter knækket ud): 21 flytter op, 23 bliver 21's højre barn. Sæt z = 23 (den gamle forælder, nu nede).
  - Vent — i den korrekte CLRS-fixup sættes z til den GAMLE z.parent FØR rotationen af knækket, og derefter farves det NYE z.parent (efter første rotation) sort, og bedsteforælderen rød, hvorefter man roterer om bedsteforælderen. Se kildekoden/simuleringen for det præcise resultat — håndregning af rotationer er fejlbarlig.
+ Efter begge rotationer og farveskift ender resultatet med:
  - 21 bliver SORT, og indtager 23's gamle plads (som barn af 18).
  - 20 og 23 bliver begge RØDE, som 21's to børn.

*Praktisk råd.* Rotationer i rød-sort træer er nemme at fejlregne i hovedet —
især "modsatte sider"-tilfældet, som kræver TO rotationer. Ved opgaver med flere
svarmuligheder: simulér så grundigt som muligt trin for trin, og brug evt. kode
til at verificere resultatet, hvis du har mulighed for det og er i tvivl.

*Generel tommelfingerregel* til at genkende resultatet uden fuld simulering: Når
en "modsatte sider"-konflikt opstår tæt på bunden af træet, ender den MIDTERSTE af
de tre involverede nøgler (her: 21, imellem 20 og 23) typisk med at blive den nye
SORTE knude på toppen af det lille subtræ, med de to oprindelige knuder (20 og 23)
som dens RØDE børn. Dette er en nyttig hurtig genkendelsesregel, men bør bekræftes
ved fuld simulering hvis muligt.

=== Aggregerede værdier i rød-sorte træer (mønster, fx `ssg`)
*Kerneindsigt.* Når en knude `v` i et rød-sort træ (eller BST generelt) gemmer en
aggregeret værdi over hele sit undertræ — fx `ssg` (sum of square gaps) — kan
værdien for `v` ofte udregnes ud fra børnenes værdier plus et "overgangsbidrag"
der dækker de elementer, som først bliver nabopar, når man sætter venstre og højre
undertræ sammen via `v`.

*Hvorfor.* Inorder-gennemløb af undertræet rodet i `v` giver rækkefølgen:

```
[... v.l's nøgler ..., v.l.max, v.x, v.r.min, ... v.r's nøgler ...]
```

Alle "interne" nabopar findes allerede inde i venstre og højre undertræ — det er
dækket af `v.l.ssg` og `v.r.ssg`. Men der opstår to nye nabopar, som ikke fandtes
i børnenes egne lister:
+ `(v.l.max, v.x)` — overgangen fra venstre undertræ til `v`.
+ `(v.x, v.r.min)` — overgangen fra `v` til højre undertræ.

*Formel:*

```
v.ssg = v.l.ssg + (v.x - v.l.max)² + (v.x - v.r.min)² + v.r.ssg
```

*Generaliseret princip (kan genbruges).* For en aggregeret egenskab over en
sorteret sekvens, der er sammensat af under-sekvenser (fx via et BST), gælder
typisk:

```
aggregat(helhed) = aggregat(venstre del)
                 + bidrag(grænseelement venstre, midterelement)
                 + bidrag(midterelement, grænseelement højre)
                 + aggregat(højre del)
```

hvor "grænseelementerne" er `min` / `max` af de respektive undertræer — ikke
`v.l.x` / `v.r.x`, da rodens egen nøgle i et undertræ ikke nødvendigvis er den
nærmeste nabo i sorteret rækkefølge.

*Tjekliste til lignende opgaver:*
- Identificer hvilken sorteret sekvens undertræet repræsenterer (inorder).
- Find ud af hvor "samlingen" af venstre + midte + højre skaber nye nabopar.
- Brug `min` / `max` af undertræer til at finde de korrekte grænseværdier — ikke rod-nøglen.
- Tjek at antallet af nye bidrag matcher antallet af nye nabopar (her: 2 — ét for hver overgang).
