extends Area2D
@export var spawn_height = 100;
func _on_body_exited(body: Node2D) -> void:
	Global.p1_respawn_point = Vector2(self.global_position.x, self.global_position.y - spawn_height)
