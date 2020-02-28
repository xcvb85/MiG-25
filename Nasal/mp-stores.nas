# this is temporary and not using emesary
var pylon = 0;
var type = 0;
var count = 0;
var set = 0;

var loop = func {
	pylon += 1;
	if (pylon == 5) {
		pylon = 0;
	}
	type = getprop("payload/armament/station/id-"~pylon~"-type");
	count = getprop("payload/armament/station/id-"~pylon~"-count");
	set = getprop("payload/armament/station/id-"~pylon~"-set");
	setprop("sim/multiplay/generic/string[5]", sprintf("%02d--%s++%02d--%s",pylon,type,count,set));
}
maketimer(0.25, loop);

