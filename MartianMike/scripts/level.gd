extends Node2D

@onready var spawn: Node = $Start
@onready var finish: Node = $Finish
@onready var deathzone: Node = $Deathzone
@onready var hud: Node = $UI/HUD
@onready var ui: Node  = $UI
var player: Node = null
var timer: Node = null

@export var levelTime: int = 5
var timeLeft: float
var win: bool = false

@export var nextLevel: PackedScene = null
@export var isFinalLevel: bool = false

func _ready():
	player = get_tree().get_first_node_in_group("player")
	if player != null:
		player.global_position = spawn.getSpawnPosition()
	
	var traps: Array[Node] = get_tree().get_nodes_in_group("traps")
	for trap in traps:
		trap.touchedPlayer.connect(_on_trap_touched_player)
	
	finish.body_entered.connect(_on_finish_body_entered)
	deathzone.body_entered.connect(_on_deathzone_body_entered)
	
	timeLeft = levelTime
	hud.setTime(timeLeft)
	
	timer = Timer.new()
	timer.name = "LevelTimer"
	timer.wait_time = 1
	timer.timeout.connect(_on_leveltimer_timeout)
	add_child(timer)
	timer.start()

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
	timeLeft = levelTime
	hud.setTime(timeLeft)

func _on_finish_body_entered(body):
	if (body is Player) && (isFinalLevel || (nextLevel != null)):
		win = true
		finish.animate()
		player.active = false
		await get_tree().create_timer(1.5).timeout
		if isFinalLevel:
			ui.showWinScreen(true)
		else:
			get_tree().change_scene_to_packed(nextLevel)

func _on_leveltimer_timeout():
	if !win:
		timeLeft -= 1
		hud.setTime(timeLeft)
		if timeLeft < 0:
			resetPlayer()
