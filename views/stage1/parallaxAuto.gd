extends ParallaxBackground

export var speed: float = -1

func _physics_process(delta):
	self.scroll_offset.x += speed
