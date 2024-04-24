extends BoxContainer

@onready var beating_anim = preload("res://Resources/Animations/sprite-anim.tres")
@onready var lost_anim = preload("res://Resources/Animations/heart_lost.tres")
@onready var regained_anim = preload("res://Resources/Animations/heart_regained.tres")

func _ready():
	beating_anim.current_frame = 0
	lost_anim.current_frame = 0
	regained_anim.current_frame = 0

func remove_heart():
	var cur_hp = PlayerController.player_health
	var heart : TextureRect = get_node(str(cur_hp + 1))
	lost_anim.current_frame = 0
	lost_anim.pause = false
	heart.set_texture(lost_anim)
	var t = Timer.new()
	add_child(t)
	t.start(0.40)
	t.one_shot = true
	t.timeout.connect(func(): heart.visible = false)

func add_heart():
	var cur_hp = PlayerController.player_health
	var heart = get_node(str(cur_hp))
	heart.visible = true
	regained_anim.current_frame = 0
	regained_anim.pause = false
	heart.set_texture(regained_anim)
	var t = Timer.new()
	add_child(t)
	t.start(0.78)
	t.one_shot = true
	t.timeout.connect(func(): heart.texture = beating_anim)
