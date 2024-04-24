extends CharacterBody3D

func _physics_process(delta):
	move_and_slide()


func _on_area_3d_body_entered(body):
	if not (body is Enemy):
		queue_free()
		return
	
	body.die()
	queue_free()
