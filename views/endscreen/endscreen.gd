extends Node2D

func _ready():
	GameAudio.play_sound("levelcompleted1")

func _on_btnReturn_clicked():
	get_tree().change_scene("res://views/mainmenu.tscn")
