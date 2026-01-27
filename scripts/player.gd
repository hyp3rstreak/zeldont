extends CharacterBody2D
@onready var animator: AnimatedSprite2D = $AnimatedSprite2D

const SPEED = 250
var input_dir
var sprite_dir
var lastMove: Vector2
var idle_pos:="front"

func _physics_process(delta: float) -> void:
	input_dir = _get_input_dir()
	velocity = input_dir * SPEED
	print("Vel:::::: ",velocity)
	get_animation(input_dir)

	move_and_slide()
	if input_dir != Vector2(0,0):
		lastMove = input_dir
		print(": ",lastMove)

func get_animation(dir: Vector2):
	if dir.x > 0:
		animator.play("runRight")
	elif  dir.x < 0:
		animator.play("runLeft")
	elif dir.y > 0:
		animator.play("runFront")
	elif dir.y < 0:
		animator.play("runBack")
	else:
		print(idle_pos)
		if idle_pos == "front":
			animator.play("idleFront")
		elif idle_pos == "back":
			animator.play("idleBack")
		elif idle_pos == "right":
			animator.play("idleRight")
		elif idle_pos == "left":
			animator.play("idleLeft")	
			
func _get_input_dir():
	#print("right: ",int(Input.is_action_pressed("right")))
	#print("left: ",int(Input.is_action_pressed("left")))
	#print("up: ",int(Input.is_action_pressed("up")))
	#print("down: ",int(Input.is_action_pressed("down")))
	var x = -int(Input.is_action_pressed("left"))+int(Input.is_action_pressed("right"))
	var y = -int(Input.is_action_pressed("up"))+int(Input.is_action_pressed("down"))
	input_dir = Vector2(x,y).normalized()
	#print(input_dir)
	if input_dir.x != 0 and abs(input_dir.x) != 1:
		input_dir.x = 0
	if input_dir.y != 0 and abs(input_dir.y) != 1:
		input_dir.y = 0	
		
	if Input.is_action_just_released("left"):
		idle_pos = "left"
	elif Input.is_action_just_released("right"):
		idle_pos = "right"
	elif Input.is_action_just_released("up"):
		idle_pos = "back"
	elif Input.is_action_just_released("down"):
		idle_pos = "front"
		
	return input_dir
