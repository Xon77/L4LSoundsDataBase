# A sound library example sorted for [Live 4 Life project](https://github.com/Xon77/Live4Life) !

<span class="badge-buymeacoffee"><a href="https://ko-fi.com/live4life" title="Donate to this project using Buy Me A Coffee"><img src="https://img.shields.io/badge/buy%20me%20a%20coffee-donate-yellow.svg" alt="Buy Me A Coffee donate button" /></a></span> &nbsp;&nbsp; <span class="badge-patreon"><a href="https://patreon.com/live4life" title="Donate to this project using Patreon"><img src="https://img.shields.io/badge/patreon-donate-yellow.svg" alt="Patreon donate button" /></a></span>

This sound library, which is in development to work specifically with the spatial sound performance tool [Live 4 Life](https://github.com/Xon77/Live4Life), will be the basis for spatial workshops and my personal and collaborative open source creations. It is a first try to adapt, sort, clean and fit this collection for the buffer module of the performance tool [Live 4 Life](https://github.com/Xon77/Live4Life) to get a default minimum sound folder. Other sound collections and categories will be added in the future in order to be able to play with different sound sources and associations.

Currently, it gathers:
1. a collection of [Drum Machines](https://github.com/ritchse/tidal-drum-machines/tree/main/machines) for SuperDirt and Tidal from [Renzo Torr](https://github.com/ritchse) (begins with the 1st letter `D`),
2. a selection from the [set of samples used in SuperDirt and the TidalCycles](https://github.com/tidalcycles/Dirt-Samples) (begins with the 1st letter `T`),
3. a collection of Hardcore Kicks (Eigene Hardcore Kicks 2) downloaded free from unknown source (begins with the 1st letter `U`),
3. a collection of Hardcore sounds from [VoidVertex](https://github.com/VoidVertex/Sounds) (begins with the 1st letter `V`),
4. A collection of my own personal pieces and modified samples, improvisations (begins with the 1st letter `Z`).

Download the package and put simply the folder [`SoundFolder`](/SoundFolder) on your desktop to use it with the spatial performance tool.

---

### List and sort of drum machines from [Renzo Torr](https://github.com/ritchse)

See the original full list of drum machines [here](https://github.com/Xon77/tidal-drum-machines/tree/main/machines), which has been mainly resorted by category [here](/DrumMachines) thanks to the code in the file [`SoundsLibrary_Utility.scd`](/SoundsLibrary_Utility.scd), where you find different code snippets e.g.: 
* how to batch change sound file names by adding names of folders [here](/SoundsLibrary_Utility.scd#L44-L123), 
* how to explore and sort this collection of sound files [by category](/SoundsLibrary_Utility.scd#L131-L187) or [by machine](/SoundsLibrary_Utility.scd#L412-L418),
* or how to move or copy files by category into specific sound folders [here](/SoundsLibrary_Utility.scd#L199-L220).

For now, the collection of sounds may have clicks over the edges. Later, I will add a new branch with faded sounds. 

---

### My way to build and organise a sound library with groups or links for [Live 4 Life project](https://github.com/Xon77/Live4Life) :

1. As you can see below or in the [new resorted folder](/SoundFolder), each sound folder name should ideally begin and be formatted and classified by 2 letters:
	* the first letter to identify a category, e.g. `D` for the specific collection of drum machines from [Renzo Torr](https://github.com/ritchse),
	* the second letter to identify another category, colour or register within this collection.
	
	This formatting allows to have in the tool new *virtual* folders and categories between folders, whose one of the letters is identical, e.g. the first letter `D` to gather together the whole collection of drums from [Renzo Torr](https://github.com/ritchse), the second letter `D` for all toms, or `B` to gather bass and kick drums with other similar sounds or associations with sounds with low pitches to come.

2. Since I try to build sound folders with a minimum of 10 or 20 and a maximum of 100 or 200 sounds in order that the buffer module is both playable and diverse, some drum categories, like the second letter `B Bass drum`, `C Snare drum` and `M Other percussions`, are not gathered together with other folders, but have been splitted here in 3 by alphabetical name of drum machines (*A to R*, *Roland*, *S to Yamaha*), where *Roland* has its specific folder due to the huge number of sounds present in this category. However, it might have been better to split  some folders, like `M Other percussions` by family (conga and others...), or `B` by separating Bass drum and Kick drum rather than with the name of drum machines.

3. The content of each sound folder should be also ideally sorted in a specific way, e.g. from low to high pitches, although it has not yet been taken into consideration here, since I kept the original sort.

Once you've organized your sound folder, you should not change its structure, because a change in the sound folder by adding, moving or deleting a file will change the presets you have stored, since the path to your sounds is not absolute, but relative.


---


### Sound categories and abbreviations sorted by groups or families

| Group | Categories                     | Abbreviation |  Nb of files  |
|:-----------------------------------:|:------------|:------------|-----:|
| DB          | Bass drum, Kick drum                | bd          |  420 |
| DC          | Snare drum                          | sd          |  446 |
| DD          | Low tom                             | lt          |  150 |
| DD          | Medium tom                          | mt          |  113 |
| DD          | High tom                            | ht          |  123 |
| DK          | Clap                                | cp          |   57 |
| DK          | Rimshot                             | rim         |   59 |
| DM          | Other percussions                   | perc        |  330 |
| DN          | Cowbell                             | cb          |   49 |
| DN          | Tambourine                          | tb          |   32 |
| DO          | Closed hi-hat                       | hh          |  120 |
| DO          | Open hi-hat                         | oh          |  102 |
| DS          | Crash                               | cr          |  100 |
| DS          | Ride                                | rd          |   59 |
| DS          | Shakers (and maracas, cabasas, etc) | sh          |   52 |
| DX          | Effects                             | fx          |    6 |
| DX          | Miscellaneous samples               | misc        |  130 |
| `D-`        | `Sub-Total Drum Machines`           | -------------- | `2348` |
| TA          | Amen Break Loop and cutups          | -          |  33 |
| TB          | Bass drum, Kick drum, Gabber kick	            | bd         |  67  |
| TC          | Snare drum	            | sd         |  52  |
| TG          | Sitar	            | -         |  8  |
| TL          | Other whole Loops	            | -          |  45 |
| TV          | Voice (Alphabet, numbers and others)           | -          |  38 |
| TW          | Wind Instruments (Sax and others)           | -          |  22 |
| TX          | Miscellaneous effects and glitches               | misc        |  16 |
| `T-`        | `Sub-Total Dirt Tidal Sounds`            | -------------- | `?` |
| UB          | Hardcore kicks (softer)              | bd         |  76 |
| UB          | Hardcore kicks (harder)              | bd         | 139 |
| `U-`        | `Sub-Total Hardcore Unknown Kicks`   | -------------- | `215` |
| VA          | Amen Break Loop and cutups distorted | -          |  52 |
| VB          | Kick drum (to change to loops?)      | bd         |  15 |
| VG          | Guitar                               | -          |  162 |
| VH          | Bass                                 | -          |  35 |
| VV          | Voice and melodies                   | -          |  11 |
| VX          | FX FM (with some kicks)              | -          |  108 |
| `V-`        | `Sub-Total VoidVertex sounds`        | -------------- | `383` |
| `Z-`        | `Sub-Total Personal pieces and sounds`        | -------------- | `17` |
| **`All`**   | **`Total`**            | -------------- | **`?`** |


---

### Credits

[Renzo Torr](https://github.com/ritchse) for its huge collection of [Drum Machines](https://github.com/ritchse/tidal-drum-machines/tree/main/machines).

[Alex McLean](https://github.com/yaxu) for its huge set of samples for [TidalCycles](https://github.com/tidalcycles/Dirt-Samples).

[VoidVertex](https://github.com/VoidVertex) for its collection of [Hardcore sounds](https://github.com/VoidVertex/Sounds).

And Others downloaded from unknown source.

---

### Support options

[![ko-fi](https://ko-fi.com/img/githubbutton_sm.svg)](https://ko-fi.com/Z8Z1C1NDP)

<a href="https://www.patreon.com/Live4Life">
	<img src="https://c5.patreon.com/external/logo/become_a_patron_button@2x.png" width="160">
</a>


<!--
[![Support me on Patreon](https://img.shields.io/endpoint.svg?url=https%3A%2F%2Fshieldsio-patreon.vercel.app%2Fapi%3Fusername%3DLive4Life%26type%3Dpatrons&style=for-the-badge)](https://patreon.com/Live4Life)
-->

---

<!--
Deleted
### License

GPL 3

See the [License](/LICENSE) for more details.
-->