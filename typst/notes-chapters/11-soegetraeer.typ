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
_Noter tilføjes._


== Eksamenstips og faldgruber
_Noter tilføjes._
