extends Node

var enemy_amount : int = 1
var spawn_delay : float = 10

var elapsed_time_in_seconds : float = 0

var spawn_radius : float = 160
var player_protect_radius : float = 20

var player

var enemy_prefab : PackedScene = preload("res://Scenes/enemy_1.tscn")
@onready var arena = get_tree().current_scene.get_node("PixelationContainer/Pixelation/World")

func _process(delta):
	elapsed_time_in_seconds += delta
	
func _spawn_waves() -> void:
	for i in range(0, enemy_amount):
		var point = _select_spawn_point()
		
		var distance_from_player = point.distance_to(player.position)
		
		while (distance_from_player <= player_protect_radius):
			point = _select_spawn_point()
			distance_from_player = point.distance_to(player.position)
		
		_spawn_enemy(point)
		
func _spawn_enemy(pos : Vector3):
	var enemy = enemy_prefab.instantiate()
	enemy.position = pos
	arena.add_child(enemy)
		
func _select_spawn_point() -> Vector3:
	var distance = randf_range(0, spawn_radius)
	
	var x_dir = randf()
	var y_dir = randf()
	
	var dir : Vector2 = Vector2(x_dir, y_dir).normalized()
	var location_v2 = dir * distance
	return Vector3(location_v2.x, 2, location_v2.y)
