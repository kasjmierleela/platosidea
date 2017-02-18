//Evaluate each of these blocks in order

s.makeWindow
s.meter

(
//replace path by dragging 'setup-sctidal.scd' file here.
"/setup-sctidal.scd".load;
)

(
p.push;
p.reshaping = \elastic;
~out.ar(2);
)

//check before proceeding
p
q
currentEnvironment //ideally, you should now be inside a proxyspace

//////////////////////

(
~src = {
	var sig;
	sig = ~dirtOut0.ar;
};

~sou = {
	var src, sig, sig1, sig2;
	src = ~src.ar;

	sig1 = src;

	sig1 = XFade2.ar(DFM1.ar(sig1, 2000, 0.3, 1, 1, 0.003), DFM1.ar(sig1, 2000, 0.3, 1, 0, 0.003), LFCub.kr(1/16).range(-1.0, 1.0));

	sig2 = AllpassC.ar(src, 1, 0.5, 1);
	sig2 = JPverb.ar(sig2, 3, 0.68, 3, 0.8);

	sig = XFade2.ar(sig1 * LFNoise2.kr(1/2).exprange(0.1, 0.5).lag(2), sig2 * LFNoise2.kr(1/2).exprange(0.1, 0.5).lag(2), Duty.kr(1/2, 0, Dbrown(-1.0, 1.0, 0.1, inf)));

	// sig = sig2 + sig1;
	sig = Splay.ar(sig);
	sig = Limiter.ar(sig, 0.1);
};
)

~out = ~sou
~out.play

////////Once you've evaluated ~out.play, you should head over to atom ( or wherever you're running tidal from), and evaluate everything in 2-18-platosidea.tidal in order, you should then hear sounds.
//Play with them!

/////////////////////////

//to reload samples,
q[\dirt].loadSoundFiles("/samples/*");
//but first replace path by dragging in your samples folder here

//cleanup/////////////

(
q[\dirt].free;
p.pop;
p.clear;
currentEnvironment.clear;
)

currentEnvironment
