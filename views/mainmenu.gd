extends Node2D

func _ready():
	GameAudio.set_global_music("menu")

func _on_btnPlay_clicked():
	GlobalState.start_game()

func _on_btnScores_clicked():
	get_tree().change_scene("res://views/scoremenu.tscn")

func _on_btnQuit_clicked():
	get_tree().quit()
