# A sounds library example sorted for [Live 4 Life project](https://github.com/Xon77/Live4Life) !

This sound library is in development to work specifically with the spatial sound performance tool [Live 4 Life](https://github.com/Xon77/Live4Life).

Currently, it only gathers a huge collection of [Drum Machines](https://github.com/ritchse/tidal-drum-machines/tree/main/machines) for SuperDirt and Tidal from [Renzo Torr](https://github.com/ritchse). It is a first try to adapt, sort, clean and fit this collection for the buffer module of the performance tool [Live 4 Life](https://github.com/Xon77/Live4Life) to get a default minimum sound folder. Other sound collections and categories will be added in the future in order to be able to play with different sound sources and associations.

In the file [`SoundsLibrary_Utility.scd`](/SoundsLibrary_Utility.scd), you find different code snippets e.g.: 
* how to batch change sound file names by adding names of folders [here](/SoundsLibrary_Utility.scd#L44-L123), 
* how to explore and sort this collection of sound files [by category](/SoundsLibrary_Utility.scd#L131-L187) or [by machine](/SoundsLibrary_Utility.scd#L412-L418),
* or how to move or copy files by category into specific sound folders [here](/SoundsLibrary_Utility.scd#L199-L220).

For now, the collection of sounds may have clicks over the edges. Later, I will add a new branch with faded sounds. 


---

### List and sort of drum machines

See the original full list of drum machines [here](https://github.com/Xon77/tidal-drum-machines/tree/main/machines), which has been mainly resorted by category [here](/DrumMachines) thanks to code links above.

---

### Building a sound library with category associations

As you can see below, each name of sounds folders should be ideally formatted and classified by 2 letters:
* the first letter `D` to identify a specific collection, in this case, drum machines,
* the second letter to identify another category, colour or register within this collection.

This formatting allows in the tool new gatherings and categories between folders, whose one of the letters is identical, e.g. the first letter `D` to gather together this collection of drums, or e.g. `B` to gather bass and kick drums with other similar sounds or associations to come.


---


### Drum groups, categories and  abbreviations sorted by Folder names

| Drum groups - categories                     | Abbreviation |  Nb of files  |
|-------------------------------------|:------------|-----:|
| B - Bass drum, Kick drum                | bd          |  420 |
| C - Snare drum                          | sd          |  446 |
| D - Low tom                             | lt          |  150 |
| D - Medium tom                          | mt          |  113 |
| D - High tom                            | ht          |  123 |
| K - Clap                                | cp          |   57 |
| K - Rimshot                             | rim         |   59 |
| L - Other percussions                   | perc        |  330 |
| M - Cowbell                             | cb          |   49 |
| M - Tambourine                          | tb          |   32 |
| O - Closed hi-hat                       | hh          |  120 |
| O - Open hi-hat                         | oh          |  102 |
| S - Crash                               | cr          |  100 |
| S - Ride                                | rd          |   59 |
| S - Shakers (and maracas, cabasas, etc) | sh          |   52 |
| X - Effects                             | fx          |    6 |
| X - Miscellaneous samples               | misc        |  130 |
| `Total`                             |              | `2348` |
