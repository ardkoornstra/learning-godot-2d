extends Node2D

var enemyScene = preload("res://scenes/enemy.tscn")
@onready var spawners = $Spawners

func _on_timer_timeout():
	spawnEnemy()

func spawnEnemy():
	var spawnersArray = spawners.get_children()
	var selectedSpawner = spawnersArray.pick_random()
	var enemyInstance = enemyScene.instantiate()
	enemyInstance.global_position = selectedSpawner.global_position
	add_child(enemyInstance)
