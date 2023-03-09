extends Node
class_name Rect2CollisionComponent

export var nodeGroup: String = Rect2Col.RECT2COL_GROUP

func _ready():
	self.get_parent().add_to_group(nodeGroup)
	
