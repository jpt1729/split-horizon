extends Node

var p1
var p1_health = 5;
var p1_power_ups = [];
var p1_respawn_point = Vector2()

var jump_strength = 400
var player_speed = 500

func add_p1_power_up(power_up):
	p1_power_ups.push_back(power_up)

func _process(_delta) -> void:
	if p1_health <= 0:
		if p1:
			p1.global_position = p1_respawn_point
			p1_health = 5
			print('respawning!')
