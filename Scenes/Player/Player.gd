extends KinematicBody

var velocity = Vector3()
var speed = 30
var gravity_force = -9.8
var movement_damp = 10
var gravity_delta = 0
var jump_force = 20

onready var tween = get_node("Tween")
onready var jump_dust = get_node("JumpDust")

func _physics_process(delta):
	
	var input_velocity = get_input() * speed
	velocity.x = damp(velocity.x, input_velocity.x, movement_damp)
	velocity.z = damp(velocity.z, input_velocity.z, movement_damp)
	velocity.y += gravity(delta)
	animation()
	move_and_slide(velocity, Vector3.UP)
	
func get_input():
	
	var input_velocity = Vector3()
	
	if Input.is_action_pressed("North"):
		input_velocity.z += -1
	if Input.is_action_pressed("South"):
		input_velocity.z += 1
	if Input.is_action_pressed("East"):
		input_velocity.x += 1
	if Input.is_action_pressed("West"):
		input_velocity.x += -1
	if Input.is_action_just_pressed("Jump"):
		jump(jump_force)
		
	return input_velocity.normalized()
	
func gravity(delta):
	
	var gravity_magnitude
	
	if !is_on_floor():
		gravity_delta += delta
	else:
		gravity_delta = 0
		
	gravity_magnitude = gravity_force * pow(gravity_delta, 2)
	
	return gravity_magnitude
	
func jump(force):
	
	velocity.y = force
	gravity_delta = 0
	jump_dust.restart()
	jump_dust.emitting = true
	
func animation():
	
	if !is_on_floor():
		scale.y = abs(velocity.y / 100) + 1
	else:
		scale.y = 1
		
	scale.x = abs(velocity.x / 100) + 1
	scale.z = abs(velocity.z / 100) + 1
	
func damp(var1, var2, damp_val):
	
	var damping = ((var1 / damp_val) * (damp_val - 1)) + (var2 / damp_val)
	return damping
	
