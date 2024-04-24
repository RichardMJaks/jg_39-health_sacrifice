extends Node

@onready var hud = get_tree().current_scene.get_node("HUD/Hearts")

var player_health = 5

func player_damaged():
	if player_health > 0:
		player_health -= 1
		hud.remove_heart()

func player_healed():
	if player_health < 5:
		player_health += 1
		hud.add_heart()
