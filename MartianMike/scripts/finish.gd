extends Area2D

@onready var sprite: Node = $AnimatedSprite2D

func animate():
	sprite.play("finished")
