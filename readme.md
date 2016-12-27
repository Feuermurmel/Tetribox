# Tetribox


## About

"Nerven Sie sich auch immer an herumliegenden, ungeordneten Gegenständen? Fühlen Sie sich hilflos im Kampf gegen das Chaos? Die Tetribox ist, was Sie sich schon immer wünschten! Nie mehr wird es einen Gegenstand geben, für den es kein Ablagefach in der passenden Grösse gibt."

Die Tetriboxen können mit verschieden langen Trennwänden in einem 2.5 cm-Raster beliebig unterteilt werden. Die Einzelteile werden mit einem Laser-Cutter aus dünnem Sperrholz gefertigt und halten ohne Leim oder Schrauben zusammen.


## Prerequisites

- Asymptote [0]
	- http://asymptote.sourceforge.net/
	- Used to compile Asymptote files to PDF.

[0]: This project was tested with Asymptote Version 2.35. Earlier Versions will probably also work.


## Compiling

To compile the whole project, run `make` from the directory in which this readme is. This will generate all `asy` source files and compile them into `pdf` files. Individual files may be created or updated by passing their names to the make command, as usual. The resulting `pdf` files appear in `src/` and are ready for laser cutting.
