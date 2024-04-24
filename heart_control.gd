extends BoxContainer

@onready var beating_anim = preload("res://sprite-anim.tres")
@onready var lost_anim = preload("res://heart_lost.tres")
@onready var regained_anim = preload("res://heart_regained.tres")

func remove_heart():
	var cur_hp = PlayerController.player_health
	var heart : TextureRect = get_node(str(cur_hp + 1))
	heart.set_texture(lost_anim)
	var t = Timer.new()
	add_child(t)
	t.start(0.39)
	t.one_shot = true
	t.timeout.connect(func(): heart.visible = false)

func add_heart():
	var cur_hp = PlayerController.player_health
	var heart = get_node(str(cur_hp))
	heart.visible = true
	heart.set_texture(regained_anim)
	var t = Timer.new()
	add_child(t)
	t.start(0.78)
	t.one_shot = true
	t.timeout.connect(func(): heart.texture = beating_anim)
