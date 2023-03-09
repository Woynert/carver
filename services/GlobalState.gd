extends Node

# constants
const SCROLL_SPEED = -1

# signals
signal sig_update_score

# vars
var score = 0
var record = 0

# score
func reset_score():
	score = 0
	emit_signal("sig_update_score")
func add_score():
	score += 1
	emit_signal("sig_update_score")
func get_score():
	return score

# record
func set_record(record):
	self.record = record
func get_record():
	return record
	
