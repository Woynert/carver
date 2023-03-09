extends Node2D

onready var FILL_INITIAL_LENGTH = $barFill.rect_size.x

func _ready():
	GlobalState.connect("sig_update_score", self, "on_update_score")
	on_update_score()

func on_update_score():
	$barFill.rect_size.x = FILL_INITIAL_LENGTH * min(1, (float(GlobalState.get_score()) / GlobalState.score_finish_stage))
