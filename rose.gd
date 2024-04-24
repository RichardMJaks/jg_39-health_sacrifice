extends Node3D

var total_elapsed_time = 0
var intensity = 0.01
var float_speed = 4
var turn_speed = 2

func _physics_process(delta):
	position.y += sin(total_elapsed_time) * intensity
	rotation.y += turn_speed * delta
	total_elapsed_time += delta * float_speed
