extends Node
class_name SyncScrollSpeedComponent

func _ready():
	update_speed()
	GlobalState.connect("sig_update_speed", self, "update_speed")

func update_speed():
	self.get_parent().speed = GlobalState.get_scroll_speed()
