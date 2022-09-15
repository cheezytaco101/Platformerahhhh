extends Camera

onready var player = get_parent().get_node("Player")
onready var offset = global_transform.origin - player.global_transform.origin

func _process(delta):
	global_transform.origin.x = damp(global_transform.origin.x, player.global_transform.origin.x + offset.x, 20)
	global_transform.origin.y = damp(global_transform.origin.y, player.global_transform.origin.y + offset.y, 80)
	global_transform.origin.z = damp(global_transform.origin.z, player.global_transform.origin.z + offset.z, 20)


func damp(var1, var2, damp_val):
	
	var damping = ((var1 / damp_val) * (damp_val - 1)) + (var2 / damp_val)
	return damping
	
