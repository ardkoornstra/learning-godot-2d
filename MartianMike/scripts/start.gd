extends StaticBody2D

@onready var spawn: Node = $Spawn

func getSpawnPosition() -> Vector2:
	return spawn.global_position
