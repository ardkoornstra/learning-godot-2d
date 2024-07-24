extends CharacterBody2D

signal tookDamage

var speed: int = 300
var laserScene = preload("res://scenes/laser.tscn")
@onready var containerNode: Node = $LaserContainer

func _process(delta):
	if Input.is_action_just_pressed("shoot"):
		shoot()
	

func _physics_process(delta):
	velocity = Vector2(0,0)
	
	if Input.is_action_pressed("up"):
		velocity.y = -speed
	if Input.is_action_pressed("down"):
		velocity.y = speed
	if Input.is_action_pressed("left"):
		velocity.x = -speed
	if Input.is_action_pressed("right"):
		velocity.x = speed
	
	move_and_slide()
	
	var screenSize: Vector2 = get_viewport_rect().size
	global_position = global_position.clamp(Vector2(0,0),Vector2(screenSize.x*0.7,screenSize.y))
	

func shoot():
	var laserInstance = laserScene.instantiate()
	laserInstance.global_position = global_position
	laserInstance.global_position.x += 50
	containerNode.add_child(laserInstance)

func damage():
	tookDamage.emit()

func die():
	queue_free()
