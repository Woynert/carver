extends Node

func _ready():
	
	var children = get_children()
	var objIdx = randi() % children.size()

	for child in children:
		if (child != children[objIdx]):
			child.visible = false
		else:
			child.visible = true

