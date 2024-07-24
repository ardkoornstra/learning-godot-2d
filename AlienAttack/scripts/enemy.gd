extends Area2D

signal killed

@export var speed: int = 200

func _physics_process(delta):
	global_position.x -= speed * delta

func die():
	queue_free()

func kill():
	queue_free()
	killed.emit()

func _on_body_entered(body):
	body.damage()
	die()
