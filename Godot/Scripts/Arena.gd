extends Node2D

export(Array, PackedScene) var enemys

func _ready() -> void:
	Global.create_no = self
	Global.points = 0
	
func _exit_tree()-> void:
	Global.create_no = null

func _on_enemy_spawn_timeout() -> void:
	var enemy_position = Vector2(rand_range(-160,670),rand_range(-90,390))
	
	while enemy_position.x < 640 and enemy_position.x > -80 and enemy_position.y < 360 and enemy_position.y > -45:
		enemy_position = Vector2(rand_range(-160,670),rand_range(-90,390))
	
	var enemies_quantity  = round(rand_range(0,enemys.size() - 1 ))
	
	Global.instance_node(enemys[enemies_quantity], enemy_position, self)

func _on_difficulty_timeout():
	if $enemy_spawn.wait_time > 0.50:
		$enemy_spawn.wait_time -= 0.025

