extends Node

# constants
const SCORE_HARD_TOGGLE = 15
const INITIAL_SCROLL_SPEED = -1

const SCORE_FINISH_FIRST_STAGE = 5
const SCORE_FINISH_SECOND_STAGE = 5
var score_finish_stage = SCORE_FINISH_FIRST_STAGE

# signals
signal sig_update_score
signal sig_update_speed

func reset():
	set_scroll_speed(INITIAL_SCROLL_SPEED)
	emit_signal("sig_update_score")
	
# score
var score = 0
func add_score():
	score += 1
	emit_signal("sig_update_score")
	increase_scroll_speed()
	
	# set record
	set_record(max(get_record(), score))
	
	if (score >= (score_finish_stage * stage)):
		set_stage(self.stage+1)
		
		if (self.stage == 2):
			set_scroll_speed(INITIAL_SCROLL_SPEED)
			get_tree().change_scene("res://views/transitionStage/transitionStage.tscn")
		else:
			set_scroll_speed(INITIAL_SCROLL_SPEED)
			get_tree().change_scene("res://views/endscreen/endscreen.tscn")

func get_score():
	return score

# record
var record = 0
func set_record(record):
	self.record = record
func get_record():
	return record

# speed
var scroll_speed = INITIAL_SCROLL_SPEED
var scroll_acc = -0.1
func increase_scroll_speed():
	scroll_speed += scroll_acc
	emit_signal("sig_update_speed")
func set_scroll_speed(scroll_speed):
	self.scroll_speed = scroll_speed
	emit_signal("sig_update_speed")
func get_scroll_speed():
	return scroll_speed

# scene management
var stage = 1

func start_game():
	score = 0
	stage = 1
	reset()
	get_tree().change_scene("res://views/stage1/stage1.tscn")

func stage_retry():
	reset()
	if (stage == 1):
		score = 0
		get_tree().change_scene("res://views/stage1/stage1.tscn")
	elif (stage == 2):
		score = score_finish_stage
		get_tree().change_scene("res://views/stage2/stage2.tscn")

func set_stage(stage):
	self.stage = stage
	
func die():
	if (stage == 1):
		get_tree().change_scene("res://views/deathscreen1.tscn")
	elif (stage == 2):
		get_tree().change_scene("res://views/deathscreen2.tscn")
	
