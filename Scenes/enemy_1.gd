extends CharacterBody3D
class_name Enemy

@onready var player = $"../Player"

var speed = 3
var turning_speed = 10

func _physics_process(delta):
	if not is_on_floor():
		velocity.y -= 9.8 * delta
	
	if player:
		var dir_to_player = player.global_position - global_position
		dir_to_player.y = 0
		dir_to_player = dir_to_player.normalized()
		velocity.x = dir_to_player.x * speed
		velocity.z = dir_to_player.z * speed
	
	velocity.y = clamp(velocity.y, -9.8, 9.8)
		
	move_and_slide()
	
func die():
	PlayerController.score += 1
	queue_free()


func _on_area_3d_body_entered(body : Player):
	if not body:
		return
		
	body.take_damage()
	die()
