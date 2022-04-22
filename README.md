# A sound library example sorted for [Live 4 Life project](https://github.com/Xon77/Live4Life) !

This sound library is in development to work specifically with the spatial sound performance tool [Live 4 Life](https://github.com/Xon77/Live4Life). It will be the basis for my personal and collaborative future open source creations.

Currently, it only gathers a huge collection of [Drum Machines](https://github.com/ritchse/tidal-drum-machines/tree/main/machines) for SuperDirt and Tidal from [Renzo Torr](https://github.com/ritchse). It is a first try to adapt, sort, clean and fit this collection for the buffer module of the performance tool [Live 4 Life](https://github.com/Xon77/Live4Life) to get a default minimum sound folder. Other sound collections and categories will be added in the future in order to be able to play with different sound sources and associations.

---

### List and sort of drum machines

See the original full list of drum machines [here](https://github.com/Xon77/tidal-drum-machines/tree/main/machines), which has been mainly resorted by category [here](/DrumMachines) thanks to the code in the file [`SoundsLibrary_Utility.scd`](/SoundsLibrary_Utility.scd), where you find different code snippets e.g.: 
* how to batch change sound file names by adding names of folders [here](/SoundsLibrary_Utility.scd#L44-L123), 
* how to explore and sort this collection of sound files [by category](/SoundsLibrary_Utility.scd#L131-L187) or [by machine](/SoundsLibrary_Utility.scd#L412-L418),
* or how to move or copy files by category into specific sound folders [here](/SoundsLibrary_Utility.scd#L199-L220).

For now, the collection of sounds may have clicks over the edges. Later, I will add a new branch with faded sounds. 

---

### My way to build and organise a sound library with groups or links for [Live 4 Life project](https://github.com/Xon77/Live4Life) :

1. As you can see below or in the [new resorted folder](/DrumMachines), each sound folder name should ideally begin and be formatted and classified by 2 letters:
	* the first letter to identify a category, in this case `D` for this specific collection of drum machines,
	* the second letter to identify another category, colour or register within this collection.
	
	This formatting allows in the tool to have new *virtual* folders and categories between folders, whose one of the letters is identical, e.g. the first letter `D` to gather together this total collection of drums, or e.g. `B` to gather bass and kick drums with other similar sounds or associations with sounds with low pitches to come.

2. Since I try to build sound folders with a minimum of 10 or 20 and a maximum of 100 or 200 sounds in order that the buffer module is both playable and diverse, some drum categories, like `B Bass drum` `C Snare drum` and `L Other percussions`, have been splitted here in 3 by alphabetical name of drum machines: A to R, Roland, S to Yamaha, where Roland has its specific folder due to the huge number of sounds present in this category.

3. The content of each sound folder should be also ideally formatted in a specific way, e.g. from low to high pitches, although it has not yet been taken into consideration here, since I kept the original sort.


---


### Drum machine categories and  abbreviations sorted by groups or families

| Group | Drum categories                     | Abbreviation |  Nb of files  |
|-------------------------------------|:------------|:------------|-----:|
| B          | Bass drum, Kick drum                | bd          |  420 |
| C          | Snare drum                          | sd          |  446 |
| D          | Low tom                             | lt          |  150 |
| D          | Medium tom                          | mt          |  113 |
| D          | High tom                            | ht          |  123 |
| K          | Clap                                | cp          |   57 |
| K          | Rimshot                             | rim         |   59 |
| L          | Other percussions                   | perc        |  330 |
| M          | Cowbell                             | cb          |   49 |
| M          | Tambourine                          | tb          |   32 |
| O          | Closed hi-hat                       | hh          |  120 |
| O          | Open hi-hat                         | oh          |  102 |
| S          | Crash                               | cr          |  100 |
| S          | Ride                                | rd          |   59 |
| S          | Shakers (and maracas, cabasas, etc) | sh          |   52 |
| X          | Effects                             | fx          |    6 |
| X          | Miscellaneous samples               | misc        |  130 |
| `D`                             | `Total`             |            | `2348` |
