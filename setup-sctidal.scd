
Server.default.options.outDevice_("Built-in Output");
// Server.default.options.outDevice_("Multi-Output Device");


s.options.numBuffers = 1024 * 16;
s.options.memSize = 8192 * 16;
s.options.maxNodes = 1024 * 32;
s.options.numOutputBusChannels = 2;
s.options.numInputBusChannels = 2;

s.waitForBoot {
	~dirt = SuperDirt(2, s);

	~dirt.loadSoundFiles("/samples/*"); //replace samples folder path by dragging in your samples folder here

	s.sync;

	~dirt.start(57120, [0, 0]);

	s.sync;

	q = currentEnvironment;
	p = ProxySpace(~dirt.server).push;

	~dirtOut0.ar(q[\dirt].numChannels);
	q[\dirt].orbits[0].outBus = ~dirtOut0.bus;

	~dirtOut1.ar(q[\dirt].numChannels);
	q[\dirt].orbits[1].outBus = ~dirtOut1.bus;

};