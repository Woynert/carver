extends Sprite

func _physics_process(delta):
	self.global_position.x += GlobalState.get_scroll_speed()
