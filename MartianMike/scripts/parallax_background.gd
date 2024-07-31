extends ParallaxBackground

@export var texture: CompressedTexture2D = preload("res://assets/textures/bg/Green.png")
@export var speed: int = 10

@onready var sprite: Node = $ParallaxLayer/Sprite2D

func _ready():
	sprite.texture = texture

func _process(delta):
	sprite.region_rect.position += delta * Vector2(speed, speed)
	if sprite.region_rect.position > Vector2(64,64):
		sprite.region_rect.position -= Vector2(64,64)
