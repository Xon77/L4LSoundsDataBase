# A sounds library example sorted for [Live 4 Life project](https://github.com/Xon77/Live4Life) to come soon!

This sounds library is in development to work specifically with the sound performance tool [Live 4 Life](https://github.com/Xon77/Live4Life).

Currently, it only gathers a huge collection of [Drum Machines](https://github.com/ritchse/tidal-drum-machines/tree/main/machines) for SuperDirt and Tidal from [Renzo Torr](https://github.com/ritchse). It is a first try to adapt, sort, clean and fit this collection for the buffer module of the performance tool [Live 4 Life](https://github.com/Xon77/Live4Life) to get a default minimum sounds folder. Other sound collections and categories will be added in the future in order to be able to play with different sound sources and associations.

In the file [`SoundsLibrary_Utility.scd`](/SoundsLibrary_Utility.scd), you find different code snippets: 
* how to batch change sound file names by adding names of folders [here](/SoundsLibrary_Utility.scd#L44-L123), 
* how to explore and sort this collection of sound files [by category](/SoundsLibrary_Utility.scd#L131-L187) or [by machine](/SoundsLibrary_Utility.scd#L406-L412),
* or how to move or copy files by category into specific sound folders [here](/SoundsLibrary_Utility.scd#L199-L219).


---

### List of drum machines

See the original full list of drum machines [here](/DrumMachines).

---


### Drum categories abbreviations sorted by names of new abbreviations

| Drum categories                     | Abbreviation (old->new) |  Nb of files  |
|-------------------------------------|:------------|-----:|
| Bass drum, Kick drum                | bd -> DB          |  420 |
| Snare drum                          | sd -> DC          |  446 |
| Low tom                             | lt -> DD           |  150 |
| Medium tom                          | mt -> DE           |  113 |
| High tom                            | ht -> DF           |  123 |
| Rimshot                             | rim -> DI          |   59 |
| Clap                                | cp -> DK           |   57 |
| Other percussions                   | perc -> DL         |  330 |
| Cowbell                             | cb -> DM           |   49 |
| Tambourine                          | tb -> DN           |   32 |
| Closed hi-hat                       | hh -> DO           |  120 |
| Open hi-hat                         | oh -> DP           |  102 |
| Crash                               | cr -> DQ           |  100 |
| Ride                                | rd -> DR           |   59 |
| Shakers (and maracas, cabasas, etc) | sh -> DS           |   52 |
| Effects                             | fx -> DX           |    6 |
| Miscellaneous samples               | misc -> DZ         |  130 |
| `Total`                             |              | `2348` |
