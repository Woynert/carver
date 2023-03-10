extends Node2D

onready var obstacles = []

export(Array, Resource) var obstacles_easy: Array
export(Array, Resource) var obstacles_hard: Array

func _ready():
	randomize()

func _on_Timer_timeout():
	obstacles = []
	obstacles.append_array(obstacles_easy)
	
	if (GlobalState.get_score() >= ((GlobalState.stage -1) * GlobalState.score_finish_stage + GlobalState.SCORE_HARD_TOGGLE)):
		obstacles.append_array(obstacles_hard)
	
	# pick random obstacle
	var objId = randi() % obstacles.size()
	
	if not obstacles[objId]:
		return
	if obstacles[objId] is Resource:
		var res:Resource = obstacles[objId]
		
		# instanciate
		var ob:Node2D = res.instance()
		self.add_child(ob)
		
		# set random position
		ob.global_position.x = $top.global_position.x
		ob.global_position.y = rand_range($top.global_position.y, $bottom.global_position.y)
		
		
