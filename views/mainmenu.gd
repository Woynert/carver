extends Node2D

func _on_btnPlay_clicked():
	get_tree().change_scene("res://views/stage1/stage1.tscn")

func _on_btnScores_clicked():
	get_tree().change_scene("res://views/scoremenu.tscn")

func _on_btnQuit_clicked():
	get_tree().quit()
