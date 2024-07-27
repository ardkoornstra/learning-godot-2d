extends Node2D

var lives: int = 3
var score: int = 0

var gameOverScene = preload("res://scenes/game_over.tscn")
var pathEnemyTexture = preload("res://assets/textures/enemyBlue1.png")

@onready var player: Node = $Player
@onready var hud: Node = $UI/HUD
@onready var hitSound: Node = $Hit
@onready var explodeSound: Node = $Explode

func _ready():
	hud.setScoreLabel(score)
	hud.setLives(lives)

func _on_deathzone_area_entered(area):
	area.die()
	reduceLives()
	if lives == 0:
		endGame()

func _on_player_took_damage():
	reduceLives()
	explodeSound.play()
	if lives == 0:
		endGame()

func _on_enemy_spawner_enemy_spawned(instance):
	add_child(instance)
	instance.killed.connect(_on_enemy_killed)

func _on_enemy_killed():
	score += 100
	hud.setScoreLabel(score)
	hitSound.play()

func reduceLives():
	lives -= 1
	if lives > -1:
		hud.setLives(lives)

func endGame():
	player.die()
	await get_tree().create_timer(1.5).timeout
	var gameOver = gameOverScene.instantiate()
	$UI.add_child(gameOver)
	gameOver.setScore(score)


func _on_enemy_spawner_path_enemy_spawned(pathInstance):
	add_child(pathInstance)
	pathInstance.enemy.get_node("Sprite2D").texture = pathEnemyTexture
	pathInstance.enemy.killed.connect(_on_enemy_killed)
