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





_____________________________________________________________________________________________________________________

( // 1 -> Initialize to batch rename sound files by adding the categories to names of sound files
// First make a copy of the sounds folder to be changed
// And change a small misprint with 2 "--" in names -> see 3 files in oberheimdmx--perc folder https://github.com/ritchse/tidal-drum-machines/tree/main/machines/OberheimDMX/oberheimdmx--perc/Timbale H.wav
~soundsFolder = "/Users/xon/tidal-drum-machines2/machines/"; // Define the path of the sounds Folder
~soundsFiles = pathMatch(~soundsFolder++"*/*/*");
~soundsFolderP = ~soundsFiles.collect { |i, id| PathName(i) };
~soundsFolder0 = ~soundsFiles.collect { |i, id| ~soundsFolderP[id].pathOnly };
~soundsFolder1 = ~soundsFiles.collect { |i, id| i.split($/)[5] };
~soundsFolder2 = ~soundsFiles.collect { |i, id| i.split($/)[6].split($-)[1] };
~soundsFolder3 = ~soundsFiles.collect { |i, id| i.split($/).last };
~soundsNewNames = ~soundsFiles.collect { |i, id|
	(~soundsFolder0[id] ++ ~soundsFolder1[id] ++ "-" ++ ~soundsFolder2[id] ++ "-" ++ ~soundsFolder3[id]).replace(" ", ""); }; // replace added to get files without spaces to be able to move them afterwards
~soundsBuffers = 0 !~soundsFiles.size;
~soundsSampleFormats = 0 !~soundsFiles.size;
s.options.numBuffers_(100000);
s.reboot;
~soundsFiles.cs;
)


( // 2 -> Read the files with old names
{ var sf;
	~soundsFiles.do { |i, id| i.postln;
		sf = SoundFile.new; sf.openRead(i); // optional ?
		~soundsSampleFormats[id] = sf.sampleFormat;
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
s.cachedBuffersDo({ |i, id| (id.asString + i.asString).postln; });
s.cachedBuffersDo({ |i| (i.asString.split($,)[1]).postln; });
s.cachedBuffersDo({ |i| if (i.asString.split($,)[1] == "nil", {" ".postln; "Not Updated Buffer ->".postln; i.postln; " ".postln; i.updateInfo({ |i| (i.asString ++ " -> updated").postln}); }); });


// Files with a different sample rate than 44.1Khz
s.cachedBuffersDo({ |i| if ((i.asString.split($,)[3]).asInteger != 44100, {i.asString.postln}) }); // lists the files with a different sample rate than 44.1Khz
s.cachedBuffersDo({ |i| if ((i.asString.split($,)[4]).asInteger != 44100, {i.asString.split($,)[4].split($/)[6].postln}) }); // lists the sub-categories with files with a different sample rate than 44.1Khz

~categoriesWithSRDiff = List.new;
s.cachedBuffersDo({ |i| if ((i.asString.split($,)[3]).asInteger != 44100, {~categoriesWithSRDiff.add(i.asString.split($,)[4].split($/)[5])}) }); // lists the categories with files with a different sample rate than 44.1Khz
~categoriesWithSRDiff = ~categoriesWithSRDiff.as(Set).as(Array); // lists the categories with files with a different sample rate than 44.1Khz -> [ "YamahaRX5"@32Khz, "RolandD110"@39,1Khz, "RolandTR505"@22Khz, "KorgT3"@25Khz, "XdrumLM8953@33Khz or 50Khz"


// Files with a different bit depth than 16
~soundsSampleFormats.do { |i, id| if (i != "int16", {~soundsBuffers[id].postln}) };

~categoriesWithBitsDiff = List.new;
~soundsSampleFormats.do { |i, id| if (i != "int16", {~categoriesWithBitsDiff.add(~soundsBuffers[id].asString.split($,)[4].split($/)[5])}) };
~categoriesWithBitsDiff = ~categoriesWithBitsDiff.as(Set).as(Array); // lists the categories with files with a different bit depth than 16 -> [ LinnLM1 @24, RolandTR808 (@24 for the 3 first files in CP) , RolandTR909 (@24 for most files), LinnLM2 @24 ]


( // 3 -> Write the files with new names including the name of the folders
{
	~soundsFiles.do { |i, id| // i.postln;
		~soundsBuffers[id].write(~soundsNewNames[id], sampleFormat: ~soundsSampleFormats[id] /*"int16"*/ /*"int24"*/, completionMessage:{ |i| ("-> File written :"+i).postln;});
		0.001.wait;
	};
}.fork;
)


( // 4 -> Delete the files with old names
{
	~soundsFiles.do { |i, id|
		i.postln;
		File.delete(i);
		0.001.wait;
	};
}.fork;
)





_____________________________________________________________________________________________________________________

// 5 - Nb of files per category (Bass Drum, Snare Drum...)
~soundsCategories = ~soundsNewNames.collect { |i| i.split($/)[6].split($-)[1] }; ~soundsCategories.cs;
~soundsCategories.do { |i, id| if (i.size==0, {~soundsNewNames[id]}).postln; }; // allows to detect a small misprint with 2 "--" in names
// see 3 files in oberheimdmx--perc folder https://github.com/ritchse/tidal-drum-machines/tree/main/machines/OberheimDMX/oberheimdmx--perc/Timbale H.wav

~categories = ~soundsCategories.as(Set).as(Array); // Names of categories
~categoriesSizes = ~categories.collect {|i, id| ~soundsCategories.occurrencesOf(i) }; // Nb of sound files per category

// New categories sorted "according to me" by category, color, register (low->high)
~newCategories = ["DN", "DM", "DB", "DE", "DR", "DN", "DX", "DK", "DZ", "DQ", "DP", "DS", "DD", "DO", "DF", "DC", "DI"];

// Names of categories with Nb of sound files - not sorted XXX
~categories.do {|i, id| (~newCategories[id] + i + "-->" + ~categoriesSizes[id]).postln };

// Names of categories with Nb of sound files - sorted by Nb of soundfiles XXX
~categoriesOrder = ~categoriesSizes.copy.order.reverse;
~categoriesOrder.do { |i, id| (~newCategories[i] + ~categories[i]+'-->'+~categoriesSizes[i]).postln };

DC sd --> 446
DB bd --> 420
DM perc --> 330
DD lt --> 150
DZ misc --> 130
DF ht --> 123
DO hh --> 120
DE mt --> 113
DP oh --> 102
DQ cr --> 100
DI rim --> 59
DR rd --> 59
DK cp --> 57
DS sh --> 52
DN cb --> 49
DN tb --> 32
DX fx --> 6

// Names of categories with Nb of sound files - sorted by names of ~newCategories XXX
~categoriesOrder2 = ~newCategories.copy.order;
~categoriesOrder2.do { |i, id| (~newCategories[i] + ~categories[i]+'-->'+~categoriesSizes[i]).postln };

DB bd --> 420
DC sd --> 446
DD lt --> 150
DE mt --> 113
DF ht --> 123
DI rim --> 59
DK cp --> 57
DM perc --> 330
DN cb --> 49
DN tb --> 32
DO hh --> 120
DP oh --> 102
DQ cr --> 100
DR rd --> 59
DS sh --> 52
DX fx --> 6
DZ misc --> 130





_____________________________________________________________________________________________________________________

// ("pwd").unixCmd;
// ("ls").unixCmd;
// ("cd /Users/xon/Desktop/").unixCmd; ("ls").unixCmd; // does not work ?

// Put and sort remaned sound files into specific categories

// 6 - First create a folder with categories
~categoriesS = ~categories.asString.replace("[", "{"); ~categoriesS = ~categoriesS.asString.replace("]", "}"); ~categoriesS = ~categoriesS.asString.replace(" ", "");
// mkdir -p Niveau1/{Niveau2a,Niveau2b}
// Change "DrumMachines" with the desired folder name
("mkdir -p" + Platform.userHomeDir ++ "/Desktop/DrumMachines/"++~categoriesS).unixCmd;


// 7 - Move files into specific categories
~soundsFolder = "/Users/xon/tidal-drum-machines2/machines/"; // Define the path from the original modified sounds folder
~soundsFiles = pathMatch(~soundsFolder++"*/*/*");
(
{
	~soundsFiles.do { |i, id| var unixString;
		var cat = (~soundsBuffers[id].asString.split($,)[4].split($/)[6].split($-)[1]);
		unixString = ("mv" + i + Platform.userHomeDir ++ "/Desktop/DrumMachines/" ++ cat ++ "/");
		unixString.unixCmd; unixString.postln;
		// ex in terminal : mv /Users/xon/tidal-drum-machines2/machines/AJKPercusyn/ajkpercusyn-bd/AJKPercusyn-bd-Bassdrum.wav /Users/xon/Desktop/DrumMachines/bd/
		0.001.wait;
}}.fork;
)

// Still, the following file has not been moved, probably because ', and has to be moved manually
// /Users/xon/tidal-drum-machines2/machines/RolandJD990/rolandjd990-sd/RolandJD990-sd-90's-sd.wav


// 7b - Change the names of folders with old abreviations to names of new categories
~categories.do { |i, id| var unixString = ("mv" + Platform.userHomeDir ++ "/Desktop/DrumMachines/"++ i + Platform.userHomeDir ++ "/Desktop/DrumMachines/" ++ ~newCategories[id]).postln; unixString.postln; unixString.unixCmd };






_____________________________________________________________________________________________________________________

( // 8 -> Initialize Arrays to load, read and get info on files with new names and sorted
s.options.numBuffers_(100000);
~soundsFolder = "/Users/xon/Desktop/DrumMachines/"; // Define the path of the sounds Folder
~soundsFiles = pathMatch(~soundsFolder++"*/*");
~soundsBuffers = 0 !~soundsFiles.size;
~soundsNumFrames = 0 !~soundsFiles.size;
~soundsNumChannels = 0 !~soundsFiles.size;
~soundsFirstFrameL = 0 !~soundsFiles.size;
~soundsFirstFrameR = 0 !~soundsFiles.size;
~soundsLastFrameL = 0 !~soundsFiles.size;
~soundsLastFrameR = 0 !~soundsFiles.size;

s.waitForBoot {
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
}
)


( // 9 -> Get the values of the first and last samples to detect clicks on left and right channels (multichannel buffers interleave their samples)
{ // Raw attempt that does not really work
	~soundsBuffers.do { |i, id| // i.postln;
		~soundsNumFrames[id] = i.numFrames;
		~soundsNumChannels[id] = i.numChannels;
		if (~soundsNumChannels[id] == 1, {
			i.get(0, {|msg| ~soundsFirstFrameL[id] = msg.postln}); // 1st left
			i.get(~soundsNumFrames[id]-1, {|msg| ~soundsLastFrameL[id] = msg.postln}); // Last left
			~soundsFirstFrameR[id] = nil; ~soundsLastFrameR[id] = nil;
		},{
			i.get(0, {|msg| ~soundsFirstFrameL[id] = msg.postln}); // 1st left
			i.get(~soundsNumFrames[id]-2, {|msg| ~soundsLastFrameL[id] = msg.postln}); // Last left
			i.get(1, {|msg| ~soundsFirstFrameR[id] = msg.postln}); // 1st right
			i.get(~soundsNumFrames[id]-1, {|msg| ~soundsLastFrameR[id] = msg.postln}); // Last right
		});
		0.001.wait; // s.sync;
	};
}.fork;
)

~soundsFirstFrameL.cs;
~soundsLastFrameL.cs;


( // 10a -> Identify Buffers to detect clicks over a certain threshold at 1st sample on links or right channel
{ // Raw attempt that does not really work
	~soundsBuffersWithClicks1 = List.new;
	~soundsBuffersWithClicksFirstFrameL = List.new;
	~soundsBuffersWithClicksFirstFrameR = List.new;
	~soundsBuffers.do { |i, id| var thresh = 0.01; // i.postln;
		if (~soundsNumChannels[id] == 1, {
			if (~soundsFirstFrameL[id].abs >= thresh, {
				i.asString.postln; ~soundsFirstFrameL[id].round(0.001).postln;
				~soundsBuffersWithClicks1.add(i);
				~soundsBuffersWithClicksFirstFrameL.add(~soundsFirstFrameL[id]);

				// To copy (cp) or move (mv) the files to a new folder to batch fade in and out the files
				// ("cp" + ~soundsFiles[id] + "/Users/xon/Desktop/NewFolder/").unixCmd
			});
		},{
			if (~soundsFirstFrameL[id].abs >= thresh or:{~soundsFirstFrameR[id].abs >= thresh}, {
				i.asString.postln; ~soundsFirstFrameL[id].round(0.001).postln; ~soundsFirstFrameR[id].round(0.001).postln;
				~soundsBuffersWithClicks1.add(i);
				~soundsBuffersWithClicksFirstFrameL.add(~soundsFirstFrameL[id]); ~soundsBuffersWithClicksFirstFrameR.add(~soundsFirstFrameR[id]);

				// ("cp" + ~soundsFiles[id] + "/Users/xon/Desktop/ToFade/").unixCmd
			});
		});
		0.0001.wait;
	};
}.fork;
)

~nb = 0; ~soundsBuffersWithClicks1[~nb].play(mul:0.5); ~soundsBuffersWithClicks1[~nb];
~soundsBuffersWithClicks1.size;
>= 0.1 -> 128 // only on left channel
>= 0.05 -> 172 // only on left channel
>= 0.01 -> 516 // only on left channel
>= 0.001 -> 1064 // only on left channel
>= 0.0001 -> 1838 // only on left channel
>= 0.1 -> 129 // on all channels
>= 0.05 -> 174 // on all channels
>= 0.01 -> 519 // on all channels


( // 10b -> Identify Buffers to detect clicks over a certain threshold at last sample on links or right channel
{ // Raw attempt that does not really work
	~soundsBuffersWithClicks2 = List.new;
	~soundsBuffersWithClicksLastFrameL = List.new;
	~soundsBuffersWithClicksLastFrameR = List.new;
	~soundsBuffers.do { |i, id| var thresh = 0.01; // i.postln;
		if (~soundsNumChannels[id] == 1, {
			if (~soundsLastFrameL[id].abs >= thresh, {
				i.asString.postln; ~soundsLastFrameL[id].round(0.001).postln;
				~soundsBuffersWithClicks2.add(i);
				~soundsBuffersWithClicksLastFrameL.add(~soundsLastFrameL[id]);

				// To copy (cp) or move (mv) the files to a new folder to batch fade in and out the files
				// ("cp" + ~soundsFiles[id] + "/Users/xon/Desktop/NewFolder/").unixCmd
			});
		},{
			if (~soundsLastFrameL[id].abs >= thresh or:{~soundsLastFrameR[id].abs >= thresh}, {
				i.asString.postln; ~soundsLastFrameL[id].round(0.001).postln; ~soundsLastFrameR[id].round(0.001).postln;
				~soundsBuffersWithClicks2.add(i);
				~soundsBuffersWithClicksLastFrameL.add(~soundsLastFrameL[id]); ~soundsBuffersWithClicksLastFrameR.add(~soundsLastFrameR[id]);

				// ("cp" + ~soundsFiles[id] + "/Users/xon/Desktop/ToFade/").unixCmd
			});
		});
		0.0001.wait;
	};
}.fork;
)

~nb = 0; ~soundsBuffersWithClicks2[~nb].play(mul:1); ~soundsBuffersWithClicks2[~nb].postln; ("Last L -> "++~soundsBuffersWithClicksLastFrameL[~nb].round(0.001)).postln; if (~soundsBuffersWithClicksLastFrameR[~nb].notNil, {("Last R -> "++~soundsBuffersWithClicksLastFrameR[~nb].round(0.001))});
~soundsBuffersWithClicks2.size;
>= 0.1 -> 412 // only on left channel
>= 0.05 -> 727 // only on left channel
>= 0.01 -> 1513 // only on left channel
>= 0.001 -> 1978 // only on left channel
>= 0.0001 -> 2099 // only on left channel
>= 0.1 -> 439 // on all channels
>= 0.05 -> 806 // on all channels
>= 0.01 -> 1633 // on all channels


( // 11a -> Play in loop Buffers with "Clicks" at the beginning
{
	~soundsBuffersWithClicks1.do { |i, id| // i.postln;
		i.play(mul:0.5); i.postln;
		("1st L -> "++~soundsBuffersWithClicksFirstFrameL[id].round(0.001)).postln;
		if (~soundsBuffersWithClicksFirstFrameR[id].notNil, {("1st R -> "++~soundsBuffersWithClicksFirstFrameR[id].round(0.001)).postln});
		0.5.wait;
	};
}.fork;
)


( // 11b -> Play in loop Buffers with "Clicks" at the end
{
	~soundsBuffersWithClicks2.do { |i, id| // i.postln;
		i.play(mul:0.5); i.postln;
		("Last L -> "++~soundsBuffersWithClicksLastFrameL[id].round(0.001)).postln;
		if (~soundsBuffersWithClicksLastFrameR[id].notNil, {("Last R -> "++~soundsBuffersWithClicksLastFrameR[id].round(0.001)).postln});
		1.wait;
	};
}.fork;
)





_____________________________________________________________________________________________________________________

// Explore sounds Folder (Global)
~soundsFolder = "/Users/xon/tidal-drum-machines/machines/"; ~soundsFolderPath = PathName.new(~soundsFolder); // Define your sounds Folder

// https://www.geeksforgeeks.org/du-command-linux-examples/
// https://en.wikipedia.org/wiki/Du_(Unix)
// du (abbreviated from disk usage) is a standard Unix program used to estimate file space usage—space used under a particular directory or files on a file system.
~listingSoundFolders = ("du -m -L" + ~soundsFolder + " | sort -nr").unixCmdGetStdOut; // Listing de la taille des dossiers sons
~listingSoundFolders = ("du -m -d 1 -L" + ~soundsFolder + " | sort -nr").unixCmdGetStdOut; // only first directories
~listingSoundFolders = ("du -h -L" + ~soundsFolder + " | sort -nr").unixCmdGetStdOut;

~soundsFolderPath.deepFiles.cs;
~soundsFolderPath.dumpTree;


// Explore sounds Folder 2 by Drum machines
~soundsFolderPath.folders.collect { |i| i.folders.collect { |a| a.files.size }.sum }.sum; // 2350 sound files
~soundsFolderSizes = ~soundsFolderPath.folders.collect { |i| i.folders.collect { |a| a.files.size }.sum }; // Nb of sound files per folder
~soundsFolderNames = ~soundsFolderPath.folders.collect { |i| i.folderName }; ~soundsFolderNames.cs; // Names of folders
~soundsFolderNames.do { |i, id| (i+'-->'+~soundsFolderSizes[id]).postln }; // Names of folders with Nb of sound files - not sorted XXX
~soundsFolderOrder = ~soundsFolderSizes.copy.order.reverse;
~soundsFolderOrder.do { |i, id| (~soundsFolderNames[i]+'-->'+~soundsFolderSizes[i]).postln }; // Names of folders with Nb of sound files - sorted XXX


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


