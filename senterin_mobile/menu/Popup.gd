extends Popup

func _ready():
	pass
	
func _on_ToolButton_pressed():
	get_parent().get_node("AudioStreamPlayer").play()
	popup_centered_ratio(0.5)
