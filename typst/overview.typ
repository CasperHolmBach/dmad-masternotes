#set page(
  paper: "a4",
  margin: (x: 2.2cm, y: 2.2cm),
  numbering: "1",
)
#set text(font: "New Computer Modern", size: 10.5pt, lang: "en")
#set par(justify: true, leading: 0.62em)
#set heading(numbering: "1.1")
#show heading.where(level: 1): it => block(above: 1.3em, below: 0.7em)[
  #set text(size: 15pt)
  #it
]
#show heading.where(level: 2): it => block(above: 1.0em, below: 0.5em)[
  #set text(size: 12pt)
  #it
]
#show table.cell.where(y: 0): strong

#align(center)[
  #text(20pt, weight: "bold")[SE4-DMAD — Exam Rehearsal Overview]
  #v(0.2em)
  #text(12pt)[Discrete Mathematics, Algorithms & Data Structures]
  #v(0.2em)
  #text(9.5pt, fill: gray)[One-week revision plan · ranked by exam value]
]

#v(0.5em)

= How the exam actually works

The exam is a *digital multiple-choice test (MCQ)* taken on your own computer in
SDU's "DE – Digital Eksamen" system. Key facts that shape the strategy below:

#table(
  columns: (auto, 1fr),
  stroke: 0.5pt + luma(200),
  inset: 7pt,
  [Format], [Multiple choice. Questions shown one at a time; you can jump back and forth. Each question is worth a stated number of points (2–6 pts each).],
  [Multi-answer], [Many questions say *"Et eller flere korrekte svar"* (one _or more_ correct answers) — you must tick every correct option and none of the wrong ones. These are where points are won and lost.],
  [Aids], [*Limited aids allowed*: textbooks, notes, lecture slides, formula sheets. *No internet, no chatbots.* So a good cheat-sheet of mechanical procedures is gold.],
  [Reference], [Pseudocode follows *Cormen et al. (CLRS), 4th edition* — algorithm names on the exam (`PARTITION`, `BUILD-MIN-HEAP`, `RADIX-SORT`, etc.) are CLRS names.],
)

#block(
  fill: luma(245),
  inset: 9pt,
  radius: 4pt,
  width: 100%,
)[
  *The single most important fact for prioritising:* In the most recent combined
  exam (June 2025, 37 questions, ≈125 points total), *Algorithms & Data
  Structures was ≈80% of the points* and *Discrete Mathematics only ≈20%*
  (the last 5 questions, 25 pts). Spend your week accordingly — but note that the
  discrete-maths block is small, self-contained, and almost free points, so it
  must not be skipped.
]

= The two halves of the course

== Part A — Discrete Mathematics (≈20% of exam)

Compact: only *three chapters* (per the course notes, Noter 1–9). Almost every
question is mechanical once you know the definitions.

#table(
  columns: (auto, auto, 1fr),
  stroke: 0.5pt + luma(200),
  inset: 6pt,
  [Topic], [CLRS/Rosen ch.], [What you must be able to do],
  [Logic], [Ch. 1], [Logical operators (¬ ∧ ∨ ⇒ ⇔ ⊕) and precedence; truth tables (\#rows = $2^("vars")$); equivalences (e.g. $p ⇒ q ≡ ¬p ∨ q$, De Morgan); tautology / contradiction / contingency.],
  [Quantifiers], [Ch. 1.4–1.5], [∀ / ∃, nested quantifiers, _order matters_ ($∀x ∃y$ vs $∃y ∀x$), negation of quantified statements.],
  [Proof methods], [Ch. 1 + 5], [Direct proof, contraposition, proof by contradiction, *induction* (basis + induction step). Recognising a _valid_ vs _broken_ proof.],
  [Relations], [Ch. 9], [Properties: reflexive, symmetric, antisymmetric, transitive; *equivalence relation* (refl+symm+trans); *partial order* (refl+antisymm+trans); reflexive/symmetric/transitive *closures*.],
)

== Part B — Algorithms & Data Structures (≈80% of exam)

This is where the bulk of the points are. Grouped by theme below, with the slide
deck that covers each.

#table(
  columns: (auto, auto, 1fr),
  stroke: 0.5pt + luma(200),
  inset: 6pt,
  [Theme], [Slides], [Core skills tested],
  [Asymptotics & analysis], [`asymptoticAnalysis`, `algoritmeAnalyseIntro`, `invariantSlides`], [O, Ω, Θ, o, ω comparisons; analysing loop runtimes by hand.],
  [Recurrences], [`divideAndConquer*`, `strassen`], [*Master Theorem* (CLRS 4th ed.) on $T(n) = a T(n/b) + f(n)$.],
  [Sorting], [`sortingSlides`, `sortingInLinearTime`], [`PARTITION`/quicksort, mergesort, heapsort; linear-time: counting sort, radix sort, bucket sort; stability & bounds.],
  [Heaps / PQ], [`pqSlides`], [`BUILD-MIN/MAX-HEAP`, heapify, where keys can sit, extract/insert.],
  [Hashing / dictionaries], [`dictionarySlides`], [Chaining; open addressing: linear probing & *double hashing*; reconstructing insertion order.],
  [Search trees], [`augmentedBSTSlides`], [BST operations; *red-black trees*: validity (colouring), insertion + rotations; augmented trees.],
  [Greedy], [`greedySlides`], [*Huffman coding* (build tree, codeword lengths, total bits); exchange-argument reasoning.],
  [Dynamic programming], [`dynamicProgrammingSlides`, `maxSumSlides`], [Recurrence → table; runtime & *space* of a DP; memoisation.],
  [Graph traversal], [`graphTraversalSlides`, `connectedComponentsSlides`], [*BFS* (d-values, order), *DFS* (discovery/finish times, edge classification: tree/back/forward/cross), *topological sort*.],
  [Minimum spanning tree], [`mstSlides`], [*Kruskal* & *Prim*; which edge enters next; \#components during the run.],
  [Shortest paths], [`shortestPathsSlides`], [*Dijkstra* (no neg. edges), *Bellman-Ford* (handles neg., detects neg. cycles), *DAG-shortest-paths*; which algorithm is valid for a given graph.],
  [Disjoint sets], [`disjointSetsSlides`], [Union-Find forest, *union-by-rank* + *path compression*; resulting structure after a sequence.],
)

#pagebreak()

= Topic value ranking (what to study, in order)

Ranked by *return on investment* = points available × how mechanical/reliable the
method is in a one-week window. Point estimates are from the June 2025 paper and
are representative of the format.

== Tier 1 — Do these first (high points, mostly mechanical)

+ *Asymptotic analysis, recurrences & loop analysis* — _≈26 pts._ \
  The biggest single bucket: Master Theorem questions, O/Ω/Θ/o/ω true-false sets,
  and "what is the Θ-runtime of this loop". Learn the Master Theorem cases and a
  handful of growth-rate facts once, and these are nearly automatic. *Best ROI in
  the entire course.*

+ *Discrete Mathematics block* — _≈25 pts._ \
  Small, self-contained, and almost pure pattern-matching once definitions are
  memorised (logic equivalences, quantifier order, relation properties,
  induction shape). Don't let the 20% weighting fool you — per hour studied this
  is as valuable as Tier 1. Make a one-page definitions sheet (allowed aid).

+ *Graph traversal: BFS, DFS, topological sort* — _≈17 pts._ \
  Highly mechanical if you follow CLRS conventions (alphabetical adjacency
  lists, discovery/finish times). Edge classification and topological order are
  recurring earners.

== Tier 2 — Strong value, learn next

+ *Sorting* (quicksort/`PARTITION`, counting sort, radix sort) — _≈13 pts._ \
  Trace-the-array questions. Practise `PARTITION` and one pass of radix/counting
  sort by hand until reliable.

+ *MST + Disjoint sets* (Kruskal/Prim, Union-Find) — _≈9 pts._ \
  "Which edge enters next", "\#components", and union-by-rank/path-compression
  forests. Procedural and quick to drill.

+ *Greedy / Huffman* — _≈7 pts._ Build the tree, count codeword bits, total
  encoded size. One reliable procedure.

+ *Red-black trees* — _≈7 pts._ Validity-of-colouring and insertion. A bit
  fiddlier (rotations + recolouring) — worth it, but after the cheaper wins.

== Tier 3 — Finish if time remains

+ *Heaps / priority queues* — _≈6 pts._ `BUILD-HEAP` + heapify traces.
+ *Dynamic programming* — _≈6 pts._ Reading runtime/space off a given recurrence.
+ *Hashing* — _≈5 pts._ Linear probing & double hashing table reconstruction.
+ *Shortest paths* — _≈4 pts._ Mostly "which algorithm is valid here?" (neg.
  edges ⇒ not Dijkstra; cycles ⇒ not DAG method). Cheap conceptual points.

#block(
  fill: luma(245),
  inset: 9pt,
  radius: 4pt,
  width: 100%,
)[
  *If you only had two days:* Tier 1 alone (asymptotics + discrete maths +
  graph traversal) is already *≈68 pts (>half the exam)* and is the most
  mechanical material — that's your safety net.
]

= Suggested one-week plan

#table(
  columns: (auto, 1fr),
  stroke: 0.5pt + luma(200),
  inset: 7pt,
  [Day 1], [*Asymptotics & recurrences* (Tier 1.1). Memorise Master Theorem cases; drill O/Ω/Θ comparisons and loop-runtime questions from past exams.],
  [Day 2], [*Discrete Maths* (Tier 1.2) — all three chapters. Build your allowed-aid one-pager: logic equivalences, quantifier negation, relation properties, induction template.],
  [Day 3], [*Graph traversal* (Tier 1.3): BFS, DFS times + edge types, topological sort. Trace several graphs by hand.],
  [Day 4], [*Sorting* + *MST/Disjoint sets* (Tier 2). Hand-trace `PARTITION`, radix/counting sort, Kruskal, Union-Find.],
  [Day 5], [*Greedy/Huffman* + *Red-black trees* (Tier 2). Then *Heaps* (Tier 3).],
  [Day 6], [*DP, Hashing, Shortest paths* (Tier 3). Light touch — aim for recognition, not mastery.],
  [Day 7], [*Full timed mock exam* using June 2025 (and 2023/2021), then review every miss. Finalise your cheat-sheet of procedures.],
)

= Practice material in this repo

- *Most representative:* `mcq-exams/SE4-DMAD-Eksamen-Juni-2025.pdf`, `…-2023.pdf`,
  `…-2021.pdf` — the current combined MCQ format. *Do these under timed
  conditions.*
- *Older `DM507` MCQ exams* (2015–2019) — algorithms only, but same question
  style; good extra drill.
- *`written-exams/` (dm507 2008–2016)* — older _written_ format. Useful for
  understanding the algorithms deeply, but the current exam is MCQ, so treat
  these as study aids, not format practice.
- *Discrete maths:* `discrete-maths/old-exam-sets/` (DM547 + the SE4-DMAD June
  2024 excerpt) and `exercises/opgaverDM01–09.pdf`.
- *Slides:* `algorithms-datastructures/slides/` (per the table above) and
  `discrete-maths/slides/Noter1–9.pdf` (Noter 1 is itself a nice topic map).

#v(1em)
#align(center)[#text(9pt, fill: gray)[Point figures are estimates from the June 2025 paper and indicate relative weight, not a guarantee for your exam.]]
