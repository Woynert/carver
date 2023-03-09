extends Node2D

func _ready():
	$lblScore.text = str(GlobalState.get_score())
	$lblRecord.text = str(GlobalState.get_record())

func _on_btnReturn_clicked():
	get_tree().change_scene("res://views/mainmenu.tscn")
