extends KinematicBody


var speed = 6
var ground_acceleration = 8
var air_acceleration = 2
var acceleration = ground_acceleration
var jump = 6
var gravity = 12
var stick_amount = 10
var mouse_sensitivity = 3

var direction = Vector3()
var velocity = Vector3()
var movement = Vector3()
var gravity_vec = Vector3()
var grounded = true

# Interactions
var has_key = false
var lvl = 1

func _ready():
	$Control/PopupDialog.popup()
	$Music.play()
	pass

func _input(event):
	if event is InputEventMouseMotion:
		rotation_degrees.y -= event.relative.x * mouse_sensitivity / 10
		$Head.rotation_degrees.x = clamp($Head.rotation_degrees.x - event.relative.y * mouse_sensitivity / 10, -90, 90)
	if Input.is_action_just_pressed("interact") && $Head/RayCast.is_colliding() && has_key:
		print($Head/RayCast.get_collider())
		$Open.play()
		$Head/RayCast.get_collider().get_parent().get_parent().queue_free()
		has_key = false
	if Input.is_action_just_pressed("interact") && $Head/RayCast.is_colliding() :
		if $Head/RayCast.get_collider().is_in_group("key"):
			print($Head/RayCast.get_collider())
			$Open.play()
			$Head/RayCast.get_collider().get_parent().get_parent().queue_free()
			has_key = true
	direction = Vector3()
	direction.x = -Input.get_action_strength("ui_up") + Input.get_action_strength("ui_down")
	direction.z = +Input.get_action_strength("ui_left") - Input.get_action_strength("ui_right")
	direction = direction.normalized().rotated(Vector3.UP, rotation.y)
	if Input.is_action_just_pressed("fullscreen") && OS.window_fullscreen != true:
		$Control/PopupDialog.queue_free()
		OS.window_fullscreen = true
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		rotation_degrees = Vector3(0,-180,0)
		$Head.rotation_degrees = Vector3(0,90,0)
func _physics_process(delta):
	if Input.is_action_pressed("look_left"):
		rotation_degrees.y += 2
	if Input.is_action_pressed("look_right"):
		rotation_degrees.y -= 2
	if Input.is_action_pressed("look_up"):
		$Head.rotation_degrees.x += 2
	if Input.is_action_pressed("look_down"):
		$Head.rotation_degrees.x -= 2
	if Input.is_action_just_pressed("ui_home"):
		OS.window_fullscreen = true
	if is_on_floor():
		gravity_vec = -get_floor_normal() * stick_amount
		acceleration = ground_acceleration
		grounded = true
	else:
		if grounded:
			gravity_vec = Vector3.ZERO
			grounded = false
		else:
			gravity_vec += Vector3.DOWN * gravity * delta
			acceleration = air_acceleration

	if Input.is_action_just_pressed("ui_select") and is_on_floor():
		grounded = false
		gravity_vec = Vector3.UP * jump

	velocity = velocity.linear_interpolate(direction * speed, acceleration * delta)
	movement.z = velocity.z + gravity_vec.z
	movement.x = velocity.x + gravity_vec.x
	movement.y = gravity_vec.y

	move_and_slide(movement, Vector3.UP)


func _on_Button_pressed():
	if lvl == 1:
		translation = Vector3(-58.31,1.883,34.56)
		$Control/NextLevel.hide()
		$Control/NextLevel/Button.text = "Quit"
		$Control/NextLevel/gj.text = "Congratulations! You have completed the tutorial!"
		lvl = 2
		$Control/NextLevel/gj.show()
		$Music.play()
		get_parent().get_node("ViewportContainer/Viewport/Camera").queue_free()
	elif lvl == 2:
		OS.window_fullscreen = false
		get_tree().quit()


func _on_strafe_pressed():
	$Control/Strafe.queue_free()
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	$Control/CenterContainer/crosshair.show()

func _on_Interact_pressed():
	$Control/Interact.queue_free()
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	$Control/CenterContainer/crosshair.show()


func _on_Jump_pressed():
	$Control/Jump.queue_free()
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	$Control/CenterContainer/crosshair.show()


func _on_Keys_pressed():
	$Control/Keys.queue_free()
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	$Control/CenterContainer/crosshair.show()
