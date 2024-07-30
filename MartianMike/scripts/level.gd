extends Node2D

@onready var spawn: Node = $Spawn
@onready var player: Node = $Player

func _process(delta):
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
	
	if Input.is_action_just_pressed("reset"):
		get_tree().reload_current_scene()


func _on_deathzone_body_entered(body):
	resetPlayer()


func _on_trap_touched_player():
	resetPlayer()

func resetPlayer():
	player.velocity = Vector2.ZERO
	player.global_position = spawn.global_position
