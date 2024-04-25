extends Node

@onready var hud = get_tree().current_scene.get_node("HudPixelationContainer/HudPixelation/HUD/Hearts")

var player_health = 5
var score = 0

func _process(delta):
	if player_health <= 0:
		_death()

func _death():
	get_tree().current_scene.get_node("DeathScreen").visible = true
	Engine.time_scale = 0

func player_damaged():
	if player_health > 0:
		player_health -= 1
		hud.remove_heart()

func player_healed():
	if player_health < 5:
		player_health += 1
		hud.add_heart()
