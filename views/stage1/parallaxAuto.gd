extends ParallaxBackground

var speed: float = -1
func _ready():
	self.speed = GlobalState.SCROLL_SPEED
	
func _physics_process(delta):
	self.scroll_offset.x += speed
