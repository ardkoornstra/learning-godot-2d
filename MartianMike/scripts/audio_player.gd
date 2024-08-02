extends Node

var hurt = preload("res://assets/audio/hurt.wav")
var jump = preload("res://assets/audio/jump.wav")
var win = preload("res://assets/audio/win.ogg")

func playSFX(name: String):
	var stream = null
	if name == "hurt":
		stream = hurt
	elif name == "jump":
		stream = jump
	elif name == "win":
		stream = win
	else:
		return
	
	var audioPlayer = AudioStreamPlayer.new()
	audioPlayer.stream = stream
	add_child(audioPlayer)
	audioPlayer.play()
	
	await audioPlayer.finished
	audioPlayer.queue_free()
