extends Node2D

export var text: String
signal clicked

func _ready():
	$Label.text = text

func _on_Area2D_input_event(viewport, event, shape_idx):
	if (
		event is InputEventMouseButton
		and event.button_index == BUTTON_LEFT
		and not event.is_pressed()
	):
		print("released")
		emit_signal("clicked")
		GameAudio.play_sound("blip2",1,-10)

# hover colors

func _on_Area2D_mouse_entered():
	$Label.set("custom_colors/font_color", Color.lightgreen)
	GameAudio.play_sound("blip1",1,-10)

func _on_Area2D_mouse_exited():
	$Label.set("custom_colors/font_color", Color.white)
