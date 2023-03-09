extends Area2D

export var extraSpeedPercentage: float = 0
var speed = 0

func _physics_process(delta):
	self.global_position.x += speed * ( 1 - extraSpeedPercentage )
	
	if (self.global_position.x < -100):
		self.queue_free()
		
