extends Area




func _on_Finish_body_entered(body):
	body.get_node("Fanfare").play()
	body.get_node("Music").stop()
	body.get_node("Control").get_node("NextLevel").popup()
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
