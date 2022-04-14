// Tidal-DrumMachines SoundsFolders
// https://club.tidalcycles.org/t/a-huge-drum-machine-library-for-tidal-71-drum-machines/3408
// a minimal exploration from the sclang side from Julian Rohrhuber:

SuperDirt.start;
SuperDirt.default = ~dirt;

~path = "/Users/xon/tidal-drum-machines/machines";

~dirt.soundLibrary.loadSoundFiles(~path ++ "/*/*");

p = pathMatch("/Users/xon/tidal-drum-machines/machines/*/*");

x = p.collect { |x| x.split($/).drop(-1).last.asSymbol };

(
Tdef(\x, {
	var w = x.choose, dt = 1, dt0 = 0.1;
	loop {
		// if(0.004.coin) { w = x.choose };
		if(0.01.coin) { w = x.choose };
		if((dt/3).coin) { dt =  [1, 1/2, 1/3, 2].choose };
		wait(dt * dt0);
		(
			type: \dirt,
			s: w,
			n: 10.rand,
			pan: -0.5,
			amp: rrand(-20, -30).dbamp,
			ring: 1.0.rand,
			ringf: 3000.rand
		).play;
		w.postln;
	}
}).play
)





( // 1 Initialize to batch process the change of file names
~soundsFolder = "/Users/xon/tidal-drum-machines/machines/"; // Define the path of the sounds Folder
~soundsFiles = pathMatch(~soundsFolder++"*/*/*");
~soundsFolderP = ~soundsFiles.collect { |i, id| PathName(i) };
~soundsFolder0 = ~soundsFiles.collect { |i, id| ~soundsFolderP[id].pathOnly };
~soundsFolder1 = ~soundsFiles.collect { |i, id| i.split($/)[5] };
~soundsFolder2 = ~soundsFiles.collect { |i, id| i.split($/)[6].split($-)[1] };
~soundsFolder3 = ~soundsFiles.collect { |i, id| i.split($/).last };
~soundsNewNames = ~soundsFiles.collect { |i, id| (~soundsFolder0[id] ++ ~soundsFolder1[id] ++ "-" ++ ~soundsFolder2[id] ++ "-" ++ ~soundsFolder3[id]) };
~soundsBuffers = 0 !~soundsFiles.size;
s.options.numBuffers_(100000);
s.reboot;
~soundsFiles.cs;
)


( // 2 Read the files with old names
{ var sf;
	~soundsFiles.do { |i, id| i.postln;
		sf = SoundFile.new; sf.openRead(i); // optional ?
		~soundsBuffers[id] = Buffer.read(s, i);
		sf.close; // optional ?
		0.001.wait;
		if (id % 10 == 9, {  // adjust - here every 10th file
			// "breathing".postln;
			0.01.wait; s.sync;
			// can even add tiny .wait here but only if desperately needed
		});
	};
}.fork;
)


// Check if all info are loaded in buffers
s.cachedBuffersDo({ |i| i.asString.postln; })
s.cachedBuffersDo({ |i| (i.asString.split($,)[1]).postln; })
s.cachedBuffersDo({ |i| if (i.asString.split($,)[1] == "nil", {" ".postln; "Not Updated Buffer ->".postln; i.postln; " ".postln; i.updateInfo({ |i| (i.asString ++ " -> updated").postln}); }); });


( // 3 Write the files with new names including the name of the folders
{
	~soundsFiles.do { |i, id| // i.postln;
		~soundsBuffers[id].write(~soundsNewNames[id], sampleFormat: "int16" /*"int24"*/ ,completionMessage:{ |i| ("-> File written :"+i).postln;});
		0.001.wait;
	};
}.fork;
)


( // 4 Delete the files with old names
{
	~soundsFiles.do { |i, id|
		i.postln;
		File.delete(i);
		0.001.wait;
	};
}.fork;
)





// Nb of files per category (Bass Drum, Snare Drum...)
~soundsCategories = ~soundsNewNames.collect { |i| i.split($/)[6].split($-)[1] }; ~soundsCategories.cs
~soundsCategories.do { |i, id| if (i.size==0, {~soundsNewNames[id]}).postln; } // allows to detect a small misprint with 2 "--" in names
// see 3 files in oberheimdmx--perc folder "/Users/xon/tidal-drum-machines/machines/OberheimDMX/oberheimdmx--perc/Timbale H.wav"

~categories = ~soundsCategories.as(Set).as(Array); // Names of categories
~categoriesSizes = ~categories.collect {|i, id| ~soundsCategories.occurrencesOf(i) } // Nb of sound files per category
~categories.do {|i, id| (i + " ->" + ~categoriesSizes[id]).postln }; // Names of categories with Nb of sound files - not sorted XXX
~categoriesOrder = ~categoriesSizes.copy.order.reverse;
~categoriesOrder.do { |i, ib| (~categories[i]+'-->'+~categoriesSizes[i]).postln }; // Names of categories with sizes - sorted XXX

sd --> 446
bd --> 420
perc --> 330
lt --> 150
misc --> 130
ht --> 123
hh --> 120
mt --> 113
oh --> 102
cr --> 100
rim --> 59
rd --> 59
cp --> 57
sh --> 52
cb --> 49
tb --> 32
fx --> 6







// Explore sounds Folder 1
~soundsFolder = "/Users/xon/Desktop/_Sounds2021C/";
~soundsFolder = "/Users/xon/tidal-drum-machines/machines/"; ~soundsFolderPath = PathName.new(~soundsFolder); // Define your sounds Folder

// https://www.geeksforgeeks.org/du-command-linux-examples/
// https://en.wikipedia.org/wiki/Du_(Unix)
// du (abbreviated from disk usage) is a standard Unix program used to estimate file space usage—space used under a particular directory or files on a file system.
~listingSoundFolders = ("du -m -L" + ~soundsFolder +" | sort -nr").unixCmdGetStdOut; // Listing de la taille des dossiers sons
~listingSoundFolders = ("du -m -d 1 -L" + ~soundsFolder +" | sort -nr").unixCmdGetStdOut; // only first directories
~listingSoundFolders = ("du -h -L" + ~soundsFolder +" | sort -nr").unixCmdGetStdOut;

~soundsFolderPath.deepFiles.cs
~soundsFolderPath.dumpTree


// Explore sounds Folder 2
~soundsFolderPath.folders.collect { |i| i.folders.collect { |a| a.files.size }.sum }.sum; // 2350 sound files
~soundsFolderSizes = ~soundsFolderPath.folders.collect { |i| i.folders.collect { |a| a.files.size }.sum }; // Nb of sound files per folder
~soundsFolderNames = ~soundsFolderPath.folders.collect { |i| i.folderName }; ~soundsFolderNames.cs; // Names of folders
~soundsFolderNames.do { |i, ib| (i+'-->'+~soundsFolderSizes[ib]).postln } // Names of folders with Nb of sound files - not sorted XXX
~soundsFolderOrder = ~soundsFolderSizes.copy.order.reverse;
~soundsFolderOrder.do { |i, ib| (~soundsFolderNames[i]+'-->'+~soundsFolderSizes[i]).postln } // Names of folders with sizes - sorted XXX


[ "AJKPercusyn", "AkaiLinn", "AkaiMPC60", "AkaiXR10", "AlesisHR16", "AlesisSR16", "BossDR110", "BossDR220", "BossDR55", "BossDR550", "CasioRZ1", "CasioSK1", "CasioVL1", "DoepferMS404", "EmuDrumulator", "EmuModular", "EmuSP12", "KorgDDM110", "KorgKPR77", "KorgKR55", "KorgKRZ", "KorgM1", "KorgMinipops", "KorgPoly800", "KorgT3", "Linn9000", "LinnDrum", "LinnLM1", "LinnLM2", "MFB512", "MPC1000", "MoogConcertMateMG1", "OberheimDMX", "RhodesPolaris", "RhythmAce", "RolandCompurhythm1000", "RolandCompurhythm78", "RolandCompurhythm8000", "RolandD110", "RolandD70", "RolandDDR30", "RolandJD990", "RolandMC202", "RolandMC303", "RolandMT32", "RolandR8", "RolandS50", "RolandSH09", "RolandSystem100", "RolandTR505", "RolandTR606", "RolandTR626", "RolandTR707", "RolandTR727", "RolandTR808", "RolandTR909", "SakataDPM48", "SequentialCircuitsDrumtracks", "SequentialCircuitsTom", "SergeModular", "SimmonsSDS400", "SimmonsSDS5", "SoundmastersR88", "UnivoxMicroRhythmer12", "ViscoSpaceDrum", "XdrumLM8953", "YamahaRM50", "YamahaRX21", "YamahaRX5", "YamahaRY30", "YamahaTG33" ]


[ 5, 13, 21, 57, 19, 52, 7, 11, 13, 47, 12, 6, 3, 6, 12, 5, 68, 11, 5, 10, 12, 44, 32, 4, 27, 20, 28, 17, 23, 9, 17, 5, 20, 12, 16, 15, 20, 13, 18, 20, 24, 62, 9, 148, 30, 52, 43, 43, 62, 16, 7, 30, 14, 12, 122, 74, 20, 12, 8, 7, 20, 64, 6, 4, 40, 22, 485, 9, 13, 84, 51 ]


YamahaRM50 --> 485
RolandMC303 --> 148
RolandTR808 --> 122
YamahaRY30 --> 84
RolandTR909 --> 74
EmuSP12 --> 68
SimmonsSDS5 --> 64
RolandSystem100 --> 62
RolandJD990 --> 62
AkaiXR10 --> 57
RolandR8 --> 52
AlesisSR16 --> 52
YamahaTG33 --> 51
BossDR550 --> 47
KorgM1 --> 44
RolandSH09 --> 43
RolandS50 --> 43
ViscoSpaceDrum --> 40
KorgMinipops --> 32
RolandTR626 --> 30
RolandMT32 --> 30
LinnDrum --> 28
KorgT3 --> 27
RolandDDR30 --> 24
LinnLM2 --> 23
XdrumLM8953 --> 22
AkaiMPC60 --> 21
SimmonsSDS400 --> 20
SakataDPM48 --> 20
RolandD70 --> 20
RolandCompurhythm78 --> 20
OberheimDMX --> 20
Linn9000 --> 20
AlesisHR16 --> 19
RolandD110 --> 18
MPC1000 --> 17
LinnLM1 --> 17
RolandTR505 --> 16
RhythmAce --> 16
RolandCompurhythm1000 --> 15
RolandTR707 --> 14
YamahaRX5 --> 13
RolandCompurhythm8000 --> 13
BossDR55 --> 13
AkaiLinn --> 13
SequentialCircuitsDrumtracks --> 12
RolandTR727 --> 12
RhodesPolaris --> 12
KorgKRZ --> 12
EmuDrumulator --> 12
CasioRZ1 --> 12
KorgDDM110 --> 11
BossDR220 --> 11
KorgKR55 --> 10
YamahaRX21 --> 9
RolandMC202 --> 9
MFB512 --> 9
SequentialCircuitsTom --> 8
SergeModular --> 7
RolandTR606 --> 7
BossDR110 --> 7
SoundmastersR88 --> 6
DoepferMS404 --> 6
CasioSK1 --> 6
MoogConcertMateMG1 --> 5
KorgKPR77 --> 5
EmuModular --> 5
AJKPercusyn --> 5
UnivoxMicroRhythmer12 --> 4
KorgPoly800 --> 4
CasioVL1 --> 3

