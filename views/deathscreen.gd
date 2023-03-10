extends Node2D

func _ready():
	GameAudio.stop_global_music()

func _on_btnRetry_clicked():
	GlobalState.stage_retry()

func _on_btnBack_clicked():
	get_tree().change_scene("res://views/mainmenu.tscn")
