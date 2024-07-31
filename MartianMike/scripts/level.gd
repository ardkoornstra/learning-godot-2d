extends Node2D

@onready var spawn: Node = $Start
@onready var finish: Node = $Finish
var player: Node = null

@export var nextLevel: PackedScene = null

func _ready():
	player = get_tree().get_first_node_in_group("player")
	if player != null:
		player.global_position = spawn.getSpawnPosition()
	
	var traps: Array[Node] = get_tree().get_nodes_in_group("traps")
	for trap in traps:
		trap.touchedPlayer.connect(_on_trap_touched_player)
	
	finish.body_entered.connect(_on_finish_body_entered)

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
	player.global_position = spawn.getSpawnPosition()

func _on_finish_body_entered(body):
	if (body is Player) && (nextLevel != null):
		finish.animate()
		player.active = false
		await get_tree().create_timer(1.5).timeout
		get_tree().change_scene_to_packed(nextLevel)
