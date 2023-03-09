extends Node2D

func _ready():
	GlobalState.set_scroll_speed(-5)
	$AnimationPlayer.play("transition")
	
func _physics_process(delta):
	if (!$AnimationPlayer.is_playing()):
		GlobalState.set_stage(2)
		GlobalState.stage_retry()
