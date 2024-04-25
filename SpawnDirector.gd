extends Node

var wave_size : int = 1
var spawn_delay : float = 10

var elapsed_time_in_seconds : float = 0

var time_adjusted : bool = true

var spawn_radius : float = 160
var player_protect_radius : float = 20

var player

var enemy_prefab : PackedScene = preload("res://Scenes/enemy_1.tscn")
@onready var arena = get_tree().current_scene.get_node("PixelationContainer/Pixelation/World")

func _ready():
	call_deferred("_spawn_waves")

func _process(delta):
	elapsed_time_in_seconds += delta
	if elapsed_time_in_seconds > 30:
		_adjust_difficulty()
		elapsed_time_in_seconds = 0

func _spawn_waves() -> void:
	for i in range(0, wave_size):
		var point = _select_spawn_point()
		
		var distance_from_player = point.distance_to(player.position)
		
		while (distance_from_player <= player_protect_radius):
			point = _select_spawn_point()
			distance_from_player = point.distance_to(player.position)
		
		_spawn_enemy(point)
	
	_start_spawn_timer()

func _spawn_enemy(pos : Vector3):
	var enemy = enemy_prefab.instantiate()
	enemy.position = pos
	arena.add_child(enemy)
		
func _select_spawn_point() -> Vector3:
	var distance = randf_range(-spawn_radius, spawn_radius)
	
	var x_dir = randf_range(-1, 1)
	var y_dir = randf_range(-1, 1)
	
	var dir : Vector2 = Vector2(x_dir, y_dir).normalized()
	var location_v2 = dir * distance
	return Vector3(location_v2.x, 2, location_v2.y)
	
func _adjust_difficulty():
	if not time_adjusted:
		spawn_delay -= 0.5
		spawn_delay = clamp(spawn_delay, 5, INF)
		time_adjusted = true
	else:
		wave_size += 1
		time_adjusted = false

func _start_spawn_timer():
	var timer = get_tree().create_timer(spawn_delay)
	timer.timeout.connect(_spawn_waves)
