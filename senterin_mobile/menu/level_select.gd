extends CanvasLayer

func _on_Popup_confirmed():
	get_tree().root.get_node("/root/global").purchased = true
	$AudioStreamPlayer.play()
