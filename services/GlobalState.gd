extends Node

# constants
const SCROLL_SPEED = -1

# vars
var score = 0
var record = 0

# score
func reset_score():
	score = 0
func add_score():
	score += 1
func get_score():
	return score

# record
func set_record(record):
	self.record = record
func get_record():
	return record
	
