// SE4-DMAD — Komplette kursusnoter
// Byg fra repo-roden med:  typst compile typst/notes.typ notes.pdf
// (følg live med:          typst watch   typst/notes.typ notes.pdf )
//
// Denne fil samler kun dokumentet. Skriv selve indholdet i de enkelte
// emnefiler under  typst/notes-chapters/  — tilføj et nyt emne ved at lægge en
// fil derind og tilføje én #include-linje i afsnittet "Saml emner".

#set page(
  paper: "a4",
  margin: (x: 2.2cm, y: 2.2cm),
  numbering: "1",
)
#set text(font: "New Computer Modern", size: 10.5pt, lang: "da")
#set par(justify: true, leading: 0.62em)
#set heading(numbering: "1.1")

#show heading.where(level: 1): it => block(above: 1.4em, below: 0.8em)[
  #set text(size: 16pt)
  #it
]
#show heading.where(level: 2): it => block(above: 1.0em, below: 0.5em)[
  #set text(size: 12.5pt)
  #it
]
#show table.cell.where(y: 0): strong

// ---------------------------------------------------------------------------
// Titel
// ---------------------------------------------------------------------------
#align(center + horizon)[
  #text(24pt, weight: "bold")[SE4-DMAD — Kursusnoter]
  #v(0.4em)
  #text(13pt)[Diskret Matematik, Algoritmer og Datastrukturer]
  #v(0.6em)
  #text(10pt, fill: gray)[Casper Holm Bach]
]

#pagebreak()

// ---------------------------------------------------------------------------
// Indholdsfortegnelse
// ---------------------------------------------------------------------------
#outline(title: [Indhold], indent: auto, depth: 2)

#pagebreak()

// ---------------------------------------------------------------------------
// Saml emner
// Rækkefølge: Diskret Matematik først (selvstændig blok), derefter Algoritmer
// og Datastrukturer ordnet efter anbefalet repetitionsprioritet. Se overview.typ.
// ---------------------------------------------------------------------------

// --- Del A: Diskret Matematik ---
#include "notes-chapters/01-logik.typ"
#include "notes-chapters/02-bevismetoder.typ"
#include "notes-chapters/03-relationer.typ"

// --- Del B: Algoritmer og Datastrukturer (efter repetitionsprioritet) ---
#include "notes-chapters/04-asymptotisk-analyse.typ"
#include "notes-chapters/05-rekursionsligninger.typ"
#include "notes-chapters/06-grafgennemloeb.typ"
#include "notes-chapters/07-sortering.typ"
#include "notes-chapters/08-minimum-udspaendende-trae.typ"
#include "notes-chapters/09-disjunkte-maengder.typ"
#include "notes-chapters/10-graadige-algoritmer-huffman.typ"
#include "notes-chapters/11-soegetraeer.typ"
#include "notes-chapters/12-heaps-prioritetskoeer.typ"
#include "notes-chapters/13-dynamisk-programmering.typ"
#include "notes-chapters/14-hashing.typ"
#include "notes-chapters/15-korteste-veje.typ"
