extends RigidBody3D

## How much vertical force to apply when the player is pressing the "boost" action.
@export_range(750, 2000) var Thrust: float = 1000.0
@export_range(1, 250) var Torque: float = 100


func _ready() -> void:
	
	print("test ready")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:

	if Input.is_action_pressed("boost"):
		apply_central_force(basis.y * delta * Thrust)
	
	if Input.is_action_pressed("turn_right"):
		apply_torque(Vector3(0,0,Torque * delta))
	
	if Input.is_action_pressed("turn_left"):
		apply_torque(Vector3(0,0,-Torque * delta))
	
	if Input.is_action_pressed("ui_down"):
		apply_central_force(basis.y * delta * -Thrust)


func _on_body_entered(body: Node)-> void:
	if "Goal" in body.get_groups():
		print(body)
		landed_sequence(body.file_path)
		
	if "Failed" in body.get_groups():
		crash_sequence()
		

func crash_sequence() -> void:
	print("Kaboom")

	## retry the current scene
	get_tree().reload_current_scene()
		

func landed_sequence(next_level_file: String) -> void:
	print("Landed")
	# get_tree().quit()
	print("next_level_file")

	print(next_level_file)

	get_tree().change_scene_to_file(next_level_file)
	
		
	
		

