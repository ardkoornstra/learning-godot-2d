extends CharacterBody2D

@export var gravity: int = 400
@export var speed: int = 125
@export var jumpForce: int = 200

@onready var sprite: Node = $AnimatedSprite2D

func _physics_process(delta):
	if !is_on_floor():
		velocity.y += gravity * delta
		if velocity.y > 500:
			velocity.y = 500
	
	if Input.is_action_just_pressed("jump") && is_on_floor():
		velocity.y = -jumpForce
	
	var direction: float = Input.get_axis("left", "right")
	velocity.x = direction * speed
	move_and_slide()
