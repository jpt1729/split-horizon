extends Area2D
@export var spawn_height = 400;
func _on_body_exited(body: Node2D) -> void:
	Global.p1_respawn_point = Vector2(body.global_position.x, spawn_height)
