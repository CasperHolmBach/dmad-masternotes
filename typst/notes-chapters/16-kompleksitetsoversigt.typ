= Kompleksitetsoversigt

// Del B — Algoritmer og Datastrukturer · samlet opslagstabel til eksamen

Samlet opslagstabel over alle kursets algoritmer. Køretiderne følger samme
notation som resten af noterne: $n$ = antal elementer/knuder, $m$ = antal kanter,
$k$ = talinterval (counting/radix), $d$ = antal cifre (radix), $h$ = træhøjde,
$alpha(n)$ = invers Ackermann (praktisk konstant). Hashing-tider er
gennemsnit under simpel uniform hashing.


== Køretidskompleksitet

#table(
  columns: (1fr, auto, auto, auto),
  align: (left, center, center, center),
  table.header([Algoritme], [Bedste], [Gennemsnit], [Værste]),

  table.cell(colspan: 4, fill: luma(235))[*Sortering*],
  [Insertionsort], $O(n)$, $O(n^2)$, $O(n^2)$,
  [Selectionsort], $O(n^2)$, $O(n^2)$, $O(n^2)$,
  [Merge sort], $O(n log n)$, $O(n log n)$, $O(n log n)$,
  [Quicksort], $O(n log n)$, $O(n log n)$, $O(n^2)$,
  [Heapsort], $O(n log n)$, $O(n log n)$, $O(n log n)$,
  [Counting sort], $O(n + k)$, $O(n + k)$, $O(n + k)$,
  [Radix sort], $O(d(n + k))$, $O(d(n + k))$, $O(d(n + k))$,
  [Bucket sort], $O(n + k)$, $O(n + k)$, $O(n^2)$,

  table.cell(colspan: 4, fill: luma(235))[*Heaps og prioritetskø*],
  [Build-Heap], $O(n)$, $O(n)$, $O(n)$,
  [Heapify (sift-down)], $O(log n)$, $O(log n)$, $O(log n)$,
  [Insert / Increase-Key (sift-up)], $O(log n)$, $O(log n)$, $O(log n)$,
  [Extract-Min/Max], $O(log n)$, $O(log n)$, $O(log n)$,
  [Maximum/Minimum (peek)], $O(1)$, $O(1)$, $O(1)$,

  table.cell(colspan: 4, fill: luma(235))[*Søgetræer*],
  [Binært søgetræ (søg/indsæt/slet/min/maks/succ.)], $O(log n)$, $O(log n)$, $O(n)$,
  [Rød-sort træ (søg/indsæt/slet)], $O(log n)$, $O(log n)$, $O(log n)$,
  [Order-statistic (OS-Select / OS-Rank)], $O(log n)$, $O(log n)$, $O(log n)$,
  [Inorder-gennemløb], $O(n)$, $O(n)$, $O(n)$,

  table.cell(colspan: 4, fill: luma(235))[*Grafgennemløb*],
  [BFS], $O(n + m)$, $O(n + m)$, $O(n + m)$,
  [DFS], $O(n + m)$, $O(n + m)$, $O(n + m)$,
  [Topologisk sortering], $O(n + m)$, $O(n + m)$, $O(n + m)$,
  [Sammenhængskomponenter], $O(n + m)$, $O(n + m)$, $O(n + m)$,
  [Stærkt sammenhængende komp. (Kosaraju)], $O(n + m)$, $O(n + m)$, $O(n + m)$,

  table.cell(colspan: 4, fill: luma(235))[*Minimum udspændende træ*],
  [Prim (binær heap)], $O(m log n)$, $O(m log n)$, $O(m log n)$,
  [Kruskal], $O(m log m)$, $O(m log m)$, $O(m log m)$,

  table.cell(colspan: 4, fill: luma(235))[*Disjunkte mængder (Union-Find)*],
  [Make-Set], $O(1)$, $O(1)$, $O(1)$,
  [Find / Union (rang + stikomprimering)], [$O(alpha(n))$ amort.], [$O(alpha(n))$ amort.], [$O(alpha(n))$ amort.],
  [Find / Union (uden heuristikker)], $O(1)$, $O(n)$, $O(n)$,

  table.cell(colspan: 4, fill: luma(235))[*Grådige algoritmer*],
  [Aktivitetsudvælgelse / skedulering], $O(n)$, $O(n log n)$, $O(n log n)$,
  [Fraktioneret rygsæk], $O(n log n)$, $O(n log n)$, $O(n log n)$,
  [Huffman-kodning], $O(n log n)$, $O(n log n)$, $O(n log n)$,

  table.cell(colspan: 4, fill: luma(235))[*Dynamisk programmering*],
  [Max-sum (maxSum3)], $O(n)$, $O(n)$, $O(n)$,
  [Guldkæde / rod-cutting (bottom-up)], $O(n^2)$, $O(n^2)$, $O(n^2)$,
  [Memoisering (top-down guldkæde)], $O(n^2)$, $O(n^2)$, $O(n^2)$,

  table.cell(colspan: 4, fill: luma(235))[*Hashing*],
  [Direct addressing (søg/indsæt/slet)], $O(1)$, $O(1)$, $O(1)$,
  [Kædning — søg/slet], $O(1)$, $O(1)$, $O(n)$,
  [Kædning — indsæt], $O(1)$, $O(1)$, $O(1)$,
  [Åben adressering (søg/indsæt/slet)], $O(1)$, $O(1)$, $O(n)$,

  table.cell(colspan: 4, fill: luma(235))[*Korteste veje*],
  [Dijkstra (binær heap)], $O((n + m) log n)$, $O((n + m) log n)$, $O((n + m) log n)$,
  [Korteste veje i DAG (topo-orden)], $O(n + m)$, $O(n + m)$, $O(n + m)$,
  [Bellman-Ford], $O(n m)$, $O(n m)$, $O(n m)$,
  [Floyd-Warshall (all-pairs)], $O(n^3)$, $O(n^3)$, $O(n^3)$,
  [Johnson (all-pairs)], $O(n^2 log n + n m)$, $O(n^2 log n + n m)$, $O(n^2 log n + n m)$,
  [A\* (som Dijkstra, afhænger af heuristik)], $O((n + m) log n)$, $O((n + m) log n)$, $O((n + m) log n)$,
)


== Pladskompleksitet

Pladsforbruget angiver *ekstra* plads ud over selve inputtet (medmindre andet
fremgår). For datastrukturer angives strukturens samlede plads.

#table(
  columns: (auto, auto, 1fr),
  align: (left, center, left),
  table.header([Algoritme / struktur], [Plads], [Bemærkning]),

  table.cell(colspan: 3, fill: luma(235))[*Sortering*],
  [Insertionsort], $O(1)$, [in-place],
  [Selectionsort], $O(1)$, [in-place],
  [Merge sort], $O(n)$, [kræver hjælpe-array til fletning],
  [Quicksort], $O(log n)$, [rekursionsstak (gns.); værste $O(n)$],
  [Heapsort], $O(1)$, [in-place],
  [Counting sort], $O(n + k)$, [tælle-array + output],
  [Radix sort], $O(n + k)$, [bruger counting sort pr. ciffer],
  [Bucket sort], $O(n + k)$, [$k$ spande + elementer; værste hvis alt i én spand],

  table.cell(colspan: 3, fill: luma(235))[*Heaps og prioritetskø*],
  [Heap (struktur)], $O(n)$, [array af $n$ elementer],
  [Build-Heap / heap-operationer], $O(1)$, [in-place],

  table.cell(colspan: 3, fill: luma(235))[*Søgetræer*],
  [BST / rød-sort træ (struktur)], $O(n)$, [én knude pr. element],
  [Operationer], $O(h)$, [rekursionsstak: $O(log n)$ bal. / $O(n)$ værste],

  table.cell(colspan: 3, fill: luma(235))[*Grafgennemløb*],
  [BFS], $O(n)$, [kø + farver + afstande],
  [DFS], $O(n)$, [stak/rekursion + farver],
  [Topologisk sortering], $O(n)$, [],
  [Sammenhængskomponenter], $O(n)$, [],
  [Stærkt sammenhængende komp. (Kosaraju)], $O(n + m)$, [transponeret graf],

  table.cell(colspan: 3, fill: luma(235))[*Minimum udspændende træ*],
  [Prim], $O(n)$, [prioritetskø + nøgler],
  [Kruskal], $O(n)$, [Union-Find],

  table.cell(colspan: 3, fill: luma(235))[*Disjunkte mængder*],
  [Union-Find (struktur)], $O(n)$, [parent- og rang-arrays],

  table.cell(colspan: 3, fill: luma(235))[*Grådige algoritmer*],
  [Aktivitetsudvælgelse], $O(1)$, [bortset fra outputliste],
  [Fraktioneret rygsæk], $O(1)$, [sortering in-place],
  [Huffman-kodning], $O(n)$, [prioritetskø + kodetræ],

  table.cell(colspan: 3, fill: luma(235))[*Dynamisk programmering*],
  [Max-sum (maxSum3)], $O(1)$, [konstant antal variable],
  [Guldkæde / rod-cutting], $O(n)$, [DP-tabel],
  [Memoisering], $O(n)$, [memo-tabel],

  table.cell(colspan: 3, fill: luma(235))[*Hashing*],
  [Direct addressing], $O(|U|)$, [én plads pr. nøgle i universet $U$],
  [Kædning], $O(n + m)$, [tabel ($m$) + $n$ elementer],
  [Åben adressering], $O(m)$, [alt gemmes i selve tabellen],

  table.cell(colspan: 3, fill: luma(235))[*Korteste veje*],
  [Dijkstra], $O(n)$, [afstande + prioritetskø],
  [Korteste veje i DAG], $O(n)$, [],
  [Bellman-Ford], $O(n)$, [afstands-array],
  [Floyd-Warshall], $O(n^2)$, [afstandsmatrix],
  [Johnson], $O(n^2)$, [afstandsmatrix (selve kørslen $O(n + m)$)],
  [A\*], $O(n)$, [som Dijkstra + heuristikværdier],
)
