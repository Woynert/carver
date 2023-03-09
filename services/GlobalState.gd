extends Node

# constants
const SCORE_HARD_TOGGLE = 15
const SCORE_TO_NEXT_STAGE = 50

# signals
signal sig_update_score
signal sig_update_speed

func reset():
	score = 0
	scroll_speed = INITIAL_SCROLL_SPEED
	emit_signal("sig_update_score")
	emit_signal("sig_update_speed")

# score
var score = 0
func add_score():
	score += 1
	emit_signal("sig_update_score")
	increase_scroll_speed()
	
	# set record
	set_record(max(get_record(), score))
	
func get_score():
	return score

# record
var record = 0
func set_record(record):
	self.record = record
func get_record():
	return record

# speed
const INITIAL_SCROLL_SPEED = -1
var scroll_speed = -1
var scroll_acc = -0.1
func increase_scroll_speed():
	scroll_speed += scroll_acc
	emit_signal("sig_update_speed")
func set_scroll_speed(scroll_speed):
	self.scroll_speed = scroll_speed
func get_scroll_speed():
	return scroll_speed

# scene management
var stage = 1

func start_game():
	stage = 1
	reset()
	get_tree().change_scene("res://views/stage1/stage1.tscn")

func stage_retry():
	reset()
	if (stage == 1):
		get_tree().change_scene("res://views/stage1/stage1.tscn")
	elif (stage == 2):
		get_tree().change_scene("res://views/stage1/stage1.tscn")
	
func die():
	if (stage == 1):
		get_tree().change_scene("res://views/deathscreen1.tscn")
	elif (stage == 2):
		get_tree().change_scene("res://views/deathscreen1.tscn")
	
