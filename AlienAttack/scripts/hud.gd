extends Control

@onready var score: Node = $Score

func setScoreLabel(newScore):
	score.text = "SCORE: " + str(newScore)
