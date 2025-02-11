extends Node

var p1_health = 5;
var p1_power_ups = [];

var jump_strength = 600

func add_p1_power_up(power_up):
	p1_power_ups.push_back(power_up)
