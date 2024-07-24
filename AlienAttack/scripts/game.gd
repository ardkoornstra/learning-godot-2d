extends Node2D

var lives: int = 3
var score: int = 0

@onready var player: Node = $Player
@onready var hud: Node = $UI/HUD

func _ready():
	hud.setScoreLabel(score)

func _on_deathzone_area_entered(area):
	area.die()

func _on_player_took_damage():
	lives -= 1
	if lives == 0:
		player.die()

func _on_enemy_spawner_enemy_spawned(instance):
	add_child(instance)
	instance.killed.connect(_on_enemy_killed)

func _on_enemy_killed():
	score += 100
	hud.setScoreLabel(score)
