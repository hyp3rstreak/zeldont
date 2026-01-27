extends CharacterBody2D

const SPEED = 70
var input_dir
var sprite_dir

func _physics_process(delta: float) -> void:
	input_dir = _get_input_dir()
	velocity = input_dir * SPEED
	move_and_slide()



func _get_input_dir():
	var x = -int(Input.is_action_pressed("left"))+int(Input.is_action_pressed("right"))
	var y = -int(Input.is_action_pressed("up"))+int(Input.is_action_pressed("down"))
	input_dir = Vector2(x,y).normalized()
	print(input_dir)
	return input_dir
