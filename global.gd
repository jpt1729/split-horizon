extends Node

var p1_health = 5;
var p1_power_ups = [];

var jump_strength = 400

func add_p1_power_up(power_up):
	p1_power_ups.push_back(power_up)

func decrease_p1_health(points):
	p1_health -= points

func _process(delta: float) -> void:
	pass
