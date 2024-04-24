extends CSGBox3D

var keep : bool = true

func _process(_delta):
	call_deferred("_keep_or_remove")
	
func _keep_or_remove():
	if not keep:
		queue_free()
	
	keep = false
