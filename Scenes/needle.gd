extends CharacterBody3D

var moving : bool = true
var particles : PackedScene = preload("res://Scenes/needle_particles.tscn")

func _ready():
	print("Start rotation: ", rotation_degrees)	

func _physics_process(delta):
	if not moving:
		return
		
	velocity.y -= 10 * delta
	look_at(global_position + velocity.normalized() * 10)
	move_and_slide()

func _on_area_3d_body_entered(body):
	if not (body is Enemy):
		destroy()
		return

	body.die()
	
func destroy():
	var inst : GPUParticles3D = particles.instantiate()
	inst.position = global_position
	add_sibling(inst)
	inst.emitting = true
	inst.finished.connect(inst.queue_free)
	queue_free()
