extends Area



func _on_2_body_entered(body):
	body.get_node("Control").get_node("CenterContainer").get_node("crosshair").hide()
	body.get_node("Control").get_node("Interact").popup()
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	queue_free()

func _on_1_body_entered(body):
	body.get_node("Control").get_node("CenterContainer").get_node("crosshair").hide()
	body.get_node("Control").get_node("Strafe").popup()
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	queue_free()


func _on_3_body_entered(body):
	body.get_node("Control").get_node("CenterContainer").get_node("crosshair").hide()
	body.get_node("Control").get_node("Jump").popup()
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	queue_free()

func _on_4_body_entered(body):
	body.get_node("Control").get_node("CenterContainer").get_node("crosshair").hide()
	body.get_node("Control").get_node("Keys").popup()
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	queue_free()
