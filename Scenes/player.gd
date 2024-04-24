extends CharacterBody3D
class_name Player

const SPEED = 5.0
const JUMP_VELOCITY = 4.5
const SENSITIVITY = 0.01

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
@onready var camera = $Head/Camera3D
@onready var head = $Head
@onready var raycast : RayCast3D = $Head/Camera3D/RayCast3D
@onready var needle : Node3D = $Head/Camera3D/needle
@onready var blood : GPUParticles3D = $Head/Camera3D/Blood

var needle_angle = Vector3.ZERO

var shoot_needle = preload("res://Scenes/shoot_needle.tscn")

var can_shoot = true

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	needle_angle = needle.rotation

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		rotate_y(-event.relative.x * SENSITIVITY)
		camera.rotate_x(-event.relative.y * SENSITIVITY)
		camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-40), deg_to_rad(60))

func _process(delta):
	var col = raycast.get_collider()
	if not col:
		needle.rotation = needle_angle
	else:
		var pos : Vector3 = raycast.get_collision_point()
		needle.look_at(pos)
	
	if Input.is_action_just_pressed("shoot") and can_shoot:
		_shoot()

func _shoot():
	can_shoot = false
	_instance_needle()
	_tween_needle_anim()
	take_damage()
	
func take_damage():
	PlayerController.player_damaged()
	blood.emitting = true

func _instance_needle() -> void:
	var inst : CharacterBody3D = shoot_needle.instantiate()
	inst.position = needle.global_position
	needle.position.z = 1
	
	var dir : Vector3
	var speed = 40
	if raycast.get_collider():
		dir = raycast.get_collision_point()
		inst.velocity = (dir - needle.global_position).normalized() * speed
		add_sibling(inst)
		inst.look_at(raycast.get_collision_point())
	else:
		inst.velocity = -needle.global_transform.basis.z * speed
		add_sibling(inst)
		inst.rotation = needle.global_rotation
	
	
	

func _tween_needle_anim() -> void:
	var tween = needle.create_tween()
	tween.tween_property(needle, "position:z", -0.5, 0.4)\
	.set_delay(1)\
	.set_trans(Tween.TRANS_ELASTIC)
	tween.tween_callback(func(): can_shoot = true)

func _physics_process(delta):
	Input.get_last_mouse_velocity()
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
