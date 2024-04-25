extends Label

var score_received = false

func _process(delta):
	if get_parent().visible and not score_received:
		text = "HUMANS KILLED: " + str(PlayerController.score)
		score_received = true
