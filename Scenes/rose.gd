extends Node3D

var total_elapsed_time = 0
var skip_elapsed_time = 0
var intensity = 0.01
var float_speed = 4
var turn_speed = 2

var skip_count = 0

func _ready():
	position.y += intensity

func _process(delta):
	_animate(delta)

func _animate(delta):
	if skip_count < 2:
		skip_count += 1
		skip_elapsed_time += delta
		total_elapsed_time += delta * float_speed
		return
	position.y += sin(total_elapsed_time) * intensity
	rotation.y += turn_speed * skip_elapsed_time
	total_elapsed_time += delta * float_speed
	
	skip_count = 0
	skip_elapsed_time = 0


func _on_area_3d_body_entered(body):
	PlayerController.player_healed()
