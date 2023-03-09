extends Node2D

func _ready():
	GlobalState.connect("sig_update_score", self, "updateLabel")
	updateLabel()
	
func updateLabel():
	$Label.text = str(GlobalState.get_score())

