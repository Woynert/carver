extends Node2D

onready var obstacles = []

onready var obstacles_easy = [
	preload("res://npc/obstacleCones.tscn"),
	preload("res://npc/obstacleWaste.tscn")
	]

onready var obstacles_hard = [
	preload("res://npc/obstacleCones.tscn"),
	preload("res://npc/obstacleWaste.tscn"),
	preload("res://npc/obstacleTruck.tscn"),
	preload("res://npc/obstacleCar.tscn")
	]

func _ready():
	randomize()

func _on_Timer_timeout():
	
	if (GlobalState.get_score() < GlobalState.SCORE_HARD_TOGGLE):
		obstacles = obstacles_easy
	else:
		obstacles = obstacles_hard
	
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
		
		
