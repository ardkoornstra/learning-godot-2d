extends CharacterBody2D
class_name Player

@export var gravity: int = 400
@export var speed: int = 125
@export var jumpForce: int = 200

@onready var sprite: Node = $AnimatedSprite2D

var active: bool = true

func _physics_process(delta):
	if !is_on_floor():
		velocity.y += gravity * delta
		if velocity.y > 500:
			velocity.y = 500
	
	var direction: float = 0
	
	if active:
		if Input.is_action_just_pressed("jump") && is_on_floor():
			jump(jumpForce)
	
		direction = Input.get_axis("left", "right")
	if direction != 0:
		sprite.flip_h = (direction == -1)
	velocity.x = direction * speed
	
	move_and_slide()
	
	updateAnimations(direction)

func updateAnimations(direction):
	if is_on_floor():
		if direction == 0:
			sprite.play("idle")
		else:
			sprite.play("run")
	else:
		if velocity.y < 0:
			sprite.play("jump")
		else:
			sprite.play("fall")


func jump(force):
	AudioPlayer.playSFX("jump")
	velocity.y = -force
