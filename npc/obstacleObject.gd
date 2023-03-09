extends Area2D

var speed = 0

func _ready():
	speed = GlobalState.SCROLL_SPEED

func _physics_process(delta):
	self.global_position.x += speed
	
	if (self.global_position.x < -100):
		self.queue_free()
