extends CharacterBody2D

@export var bullet_speed = 300
@export var bullet_damage = 1
@export var bullet_distance = 100
@export var bullet_angle = 180

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	velocity.x = bullet_speed * cos(bullet_angle/180 * PI)
	velocity.y = bullet_speed * sin(bullet_angle/180 * PI)
	var collision = move_and_collide(velocity * delta)

	if collision:
		if (collision.get_collider().is_in_group("player")):
			Global.decrease_p1_health(bullet_damage)
			$AudioStreamPlayer2D.playing = true
			
		queue_free()
