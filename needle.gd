extends CharacterBody3D

const SPEED = 300
func _physics_process(delta):
	velocity = rotation * SPEED
	move_and_slide()
