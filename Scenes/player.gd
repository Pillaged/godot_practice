extends CharacterBody2D

@export var move_speed = 400.0
@onready var my_velocity = Vector2.ZERO
@export var horizontal = 0
@export var horizontal_f = 0.5
var x_pos = position.x

@export var jump_height : float = 400
@export var jump_time_to_peak : float = .6
@export var jump_time_to_descent : float = .5

var jump_velocity : float = ((2.0 * jump_height) / jump_time_to_peak) * -1.0
var jump_gravity : float = ((-2.0 * jump_height) / (jump_time_to_peak * jump_time_to_peak)) * -1.0
var fall_gravity : float = ((-2.0 * jump_height) / (jump_time_to_descent * jump_time_to_descent)) * -1.0

func _ready():
	pass
	
func _physics_process(delta):
	velocity.y += get_gravity() * delta
	velocity.x = get_input_velocity() * move_speed
	if abs(velocity.x) < .05:
		
		velocity.x = 0
	print(velocity.x)
	#Add timer here to allow movement
	
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		jump()
	
	move_and_slide()


func get_gravity() -> float:
	return jump_gravity if velocity.y < 0.0 else fall_gravity

func jump():
	velocity.y = jump_velocity

func get_input_velocity() -> float:
	# add force to horizontal instead of setting??
	if velocity.x == 0:
		horizontal = 0
	if Input.is_action_pressed("left"):
		horizontal -= horizontal_f/10
		horizontal = max(horizontal,-1.0)
		return horizontal
	if Input.is_action_pressed("right"):
		horizontal += horizontal_f/10
		horizontal = min(horizontal,1.0)
		return horizontal
	
	return 0
