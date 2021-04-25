extends Control


func _gui_input(event):
	if event:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
