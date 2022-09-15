extends StaticBody

onready var original_y = transform.origin.y
export (float) var force_damp = 100
export (Color) var flash_color = Color.cyan

func _process(delta):
	transform.origin.y = damp(transform.origin.y, original_y, 10)

func landed(force):
	transform.origin.y += force / force_damp
	#get_node("default").get_surface_material(1).albedo_color = flash_color
	
func damp(var1, var2, damp_val):
	
	var damping = ((var1 / damp_val) * (damp_val - 1)) + (var2 / damp_val)
	return damping
