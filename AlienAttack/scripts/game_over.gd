extends Control

@onready var score: Node = $Panel/Score

func setScore(newScore):
	score.text = "SCORE: " + str(newScore)

func _on_button_pressed():
	get_tree().reload_current_scene()
