# this is temporary and not using emesary
var pylon = 0;
var loop = func {
	pylon += 1;
	if (pylon == 5) {
		pylon = 0;
	}
	var type = getprop("payload/armament/station/id-"~pylon~"-type");
	var count = getprop("payload/armament/station/id-"~pylon~"-count");
	var set = getprop("payload/armament/station/id-"~pylon~"-set");
	setprop("sim/multiplay/generic/string[5]", sprintf("%02d--%s++%02d--%s",pylon,type,count,set));
	settimer(loop, 0.25);
}
loop();
