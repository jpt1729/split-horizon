extends CharacterBody2D

const BULLET = preload("res://objects/enemies/basic-enemy/bullet.tscn")
const BULLET_INIT = {
	"position": Vector2(-20, -4),
	"direction": Vector2.LEFT 
}
const SPEED = 180.0
const JUMP_VELOCITY = -400.0
const FIRE_RATE = 1
var FIRE_RATE_COUNTER = 0



@onready var navigation_agent: NavigationAgent2D = $NavigationAgent2D
@export var target: CharacterBody2D

func shoot() -> void:
	var new_bullet = BULLET.instantiate()
	new_bullet.position = BULLET_INIT["position"]
	self.add_child(new_bullet)
	
func _ready() -> void:
	set_physics_process(false)

func wait_for_physics():
	await get_tree().physice_frame

func _process(delta: float) -> void:
	var rng = RandomNumberGenerator.new()
	if FIRE_RATE_COUNTER >= (FIRE_RATE + rng.randf_range(0, 2.0)):
		shoot()
		FIRE_RATE_COUNTER = 0
	FIRE_RATE_COUNTER += delta

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	navigation_agent.target_position = target.global_position
	velocity=global_position.direction_to(navigation_agent.get_next_path_position()) * SPEED
	move_and_slide()
