extends Control

@onready var score: Node = $Score
@onready var lives: Node = $Lives

func setScoreLabel(newScore):
	score.text = "SCORE: " + str(newScore)

func setLives(newLives):
	lives.text = str(newLives)
