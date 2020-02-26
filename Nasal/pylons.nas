print("** Pylon & fire control system started. **");
var pylon1 = nil; #left outboard
var pylon2 = nil; #left inboard
var pylon3 = nil; #right inboard
var pylon4 = nil; #right outboard
var pylon5 = nil; #fuselage

var msgA = "If you need to repair now, then use Menu-Location-SelectAirport instead.";
var msgB = "Please land before changing payload.";
var msgC = "Please land before refueling.";

var fuelTank = stations.FuelTank.new("Droptank", "droptank", 5, 370, "sim/model/MiG-25/stores"); # FIXME 4th arg

var pylonSets = {
	empty: {name: "Empty", content: [], fireOrder: [], launcherDragArea: 0.0, launcherMass: 0, launcherJettisonable: 0, showLongTypeInsteadOfCount: 0, category: 1},
    # 340 = outer pylon
	fueltank: {name: "droptank", content: [fuelTank], fireOrder: [0], launcherDragArea: 0.35, launcherMass: 531, launcherJettisonable: 1, showLongTypeInsteadOfCount: 1, category: 2},

    # A/A weapons on non-wing pylons:
    R60:    {name: "2 x R-60",   content: ["R-60", "R-60"], fireOrder: [0, 1], launcherDragArea: -0.025, launcherMass: 96, launcherJettisonable: 0, showLongTypeInsteadOfCount: 0, category: 1}, # FIXME: actual drag values
    R40RD:    {name: "R-40RD",   content: ["R-40RD"], fireOrder: [0], launcherDragArea: -0.025, launcherMass: 1047, launcherJettisonable: 0, showLongTypeInsteadOfCount: 1, category: 1}, # FIXME: actual drag values
    R40TD:    {name: "R-40TD",   content: ["R-40TD"], fireOrder: [0], launcherDragArea: -0.025, launcherMass: 1047, launcherJettisonable: 0, showLongTypeInsteadOfCount: 1, category: 1}, # FIXME: actual drag values
};

var pylon1set = [pylonSets.empty, pylonSets.R40RD, pylonSets.R40TD, pylonSets.R60];
var pylon2set = [pylonSets.empty, pylonSets.R40RD, pylonSets.R40TD];
var pylon3set = [pylonSets.empty, pylonSets.R40RD, pylonSets.R40TD];
var pylon4set = [pylonSets.empty, pylonSets.R40RD, pylonSets.R40TD, pylonSets.R60];
var pylon5set = [pylonSets.empty, pylonSets.fueltank];

# var pylon1set = [pylonSets.empty, pylonSets.R60];
# var pylon2set = [pylonSets.empty];
# var pylon3set = [pylonSets.empty];
# var pylon4set = [pylonSets.empty, pylonSets.R60];
# var pylon5set = [pylonSets.empty, pylonSets.fueltank];

setprop("payload/armament/fire-control/serviceable", 1);
# TODO check electricity
pylon1 = stations.Pylon.new("Left wing outboard pylon (#1)",  0, [4.510, -4.511, -0.100], pylon1set,  0, props.globals.getNode("fdm/jsbsim/inertia/pointmass-weight-lbs[0]",1),props.globals.getNode("fdm/jsbsim/inertia/pointmass-dragarea-sqft[0]",1),func{return getprop("payload/armament/fire-control/serviceable") and 1;},func{return 1;});
pylon2 = stations.Pylon.new("Left wing inboard pylon (#2)",   1, [3.575, -3.309,  0.025], pylon2set,  1, props.globals.getNode("fdm/jsbsim/inertia/pointmass-weight-lbs[1]",1),props.globals.getNode("fdm/jsbsim/inertia/pointmass-dragarea-sqft[1]",1),func{return getprop("payload/armament/fire-control/serviceable") and 1;},func{return 1;});
pylon3 = stations.Pylon.new("Right wing inboard pylon (#3)",  2, [3.575,  3.309,  0.025], pylon3set,  2, props.globals.getNode("fdm/jsbsim/inertia/pointmass-weight-lbs[2]",1),props.globals.getNode("fdm/jsbsim/inertia/pointmass-dragarea-sqft[2]",1),func{return getprop("payload/armament/fire-control/serviceable") and 1;},func{return 1;});
pylon4 = stations.Pylon.new("Right wing outboard pylon (#4)", 3, [4.510,  4.511, -0.100], pylon4set,  3, props.globals.getNode("fdm/jsbsim/inertia/pointmass-weight-lbs[3]",1),props.globals.getNode("fdm/jsbsim/inertia/pointmass-dragarea-sqft[3]",1),func{return getprop("payload/armament/fire-control/serviceable") and 1;},func{return 1;});
pylon5 = stations.Pylon.new("Center Station",                 4, [2.800,  0.000, -0.700], pylon5set,  4, props.globals.getNode("fdm/jsbsim/inertia/pointmass-weight-lbs[4]",1),props.globals.getNode("fdm/jsbsim/inertia/pointmass-dragarea-sqft[4]",1),func{return getprop("payload/armament/fire-control/serviceable") and 1;},func{return 1;});

pylons = [pylon1, pylon2, pylon3, pylon4, pylon5];
fcs = fc.FireControl.new(pylons, [0, 3, 1, 2], ["R-40R", "R-40T", "R-60"]);
