extends Node

# constants
const SCROLL_SPEED = -1

# signals
signal sig_update_score

# score
var score = 0
func reset_score():
	score = 0
	emit_signal("sig_update_score")
func add_score():
	score += 1
	emit_signal("sig_update_score")
func get_score():
	return score

# record
var record = 0
func set_record(record):
	self.record = record
func get_record():
	return record

# scene management
var stage = 1
func stage_retry():
	if (stage == 1):
		get_tree().change_scene("res://views/stage1/stage1.tscn")
	elif (stage == 2):
		get_tree().change_scene("res://views/stage1/stage1.tscn")
	
