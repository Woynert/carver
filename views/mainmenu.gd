extends Node2D

func _on_btnPlay_clicked():
	pass # Replace with function body.

func _on_btnScores_clicked():
	get_tree().change_scene("res://views/scoremenu.tscn")

func _on_btnQuit_clicked():
	get_tree().quit()
