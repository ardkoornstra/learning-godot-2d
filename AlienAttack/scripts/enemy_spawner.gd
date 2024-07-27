extends Node2D

signal enemySpawned(instance)
signal pathEnemySpawned(pathInstance)

var enemyScene = preload("res://scenes/enemy.tscn")
var pathEnemyScene = preload("res://scenes/enemy_path.tscn")

@onready var spawners = $Spawners

func _on_timer_timeout():
	spawnEnemy()

func spawnEnemy():
	var spawnersArray = spawners.get_children()
	var selectedSpawner = spawnersArray.pick_random()
	var enemyInstance = enemyScene.instantiate()
	enemyInstance.global_position = selectedSpawner.global_position
	enemySpawned.emit(enemyInstance)

func _on_path_timer_timeout():
	spawnPathEnemy()

func spawnPathEnemy():
	var pathEnemyInstance = pathEnemyScene.instantiate()	
	pathEnemySpawned.emit(pathEnemyInstance)
