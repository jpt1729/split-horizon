extends Area2D

@export var damage_per_second = 0.5
@export var can_kill = true
@export var damage_acceleration = 0.5
@export var damage_sound: AudioStreamPlayer
var damaged_bodies = []
var timer = 0

var real_damage_per_second = damage_per_second

func _process(delta: float) -> void:
	timer += delta
	if timer >= 1.0:
		timer -= 1.0  # Reset timer while keeping leftover time
		for body in damaged_bodies:
			body.health -= real_damage_per_second
			real_damage_per_second += damage_acceleration
			if damage_sound:
				damage_sound.play()

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		damaged_bodies.push_front(body)


func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		var index = damaged_bodies.find(body)
		if index != -1:
			damaged_bodies.remove_at(index)
		real_damage_per_second = damage_per_second
