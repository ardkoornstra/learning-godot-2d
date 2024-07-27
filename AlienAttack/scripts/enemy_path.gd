extends Path2D

@onready var pathFollow: Node = $EnemyPathFollow
@onready var enemy: Node = $EnemyPathFollow/Enemy

func _ready():
	pathFollow.set_progress_ratio(1.0)

func _process(delta):
	pathFollow.progress_ratio -= 0.15*delta
	if pathFollow.progress_ratio == 0:
		queue_free()
