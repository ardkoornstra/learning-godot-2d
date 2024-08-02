extends Area2D

@onready var sprite: Node = $AnimatedSprite2D

@export var jumpForce: int = 300
func _on_body_entered(body):
	if body is Player:
		sprite.play("jump")
		AudioPlayer.playSFX("jump")
		body.jump(jumpForce)
