extends Node2D

onready var obstacles = [
	preload("res://npc/obstacleCones.tscn"),
	preload("res://npc/obstacleWaste.tscn")
	]

func _ready():
	randomize()

func _on_Timer_timeout():
	
	# pick random obstacle
	var objId = randi() % obstacles.size()
	
	if obstacles[objId] is Resource:
		var res:Resource = obstacles[objId]
		
		# instanciate
		var ob:Node2D = res.instance()
		self.add_child(ob)
		
		# set random position
		ob.global_position.x = $top.global_position.x
		ob.global_position.y = rand_range($top.global_position.y, $bottom.global_position.y)
		
		
