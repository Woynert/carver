extends ParallaxBackground

export var spdScale: float = 1
var speed: float = 0

func _physics_process(delta):
	self.scroll_offset.x += speed * spdScale
