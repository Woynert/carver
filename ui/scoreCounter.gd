extends Node2D

export var prepend = ""

func _ready():
	GlobalState.connect("sig_update_score", self, "updateLabel")
	updateLabel()
	
func updateLabel():
	$Label.text = prepend + str(GlobalState.get_score())

