extends RigidBody3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	print("test ready")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:

	if Input.is_action_pressed("boost"):
		apply_central_force(basis.y * delta * 1000.0)
	
	if Input.is_action_pressed("turn_right"):
		apply_torque(Vector3(0,0,100 * delta))
	
	if Input.is_action_pressed("turn_left"):
		apply_torque(Vector3(0,0,-100 * delta))
	
	if Input.is_action_pressed("ui_down"):
		apply_central_force(basis.y * delta * -1000.0)


func _on_body_entered(body: Node)-> void:
	if "Goal" in body.get_groups():
		print("You win")
		
	if "Failed" in body.get_groups():
		print("You loose")
		
		
	
		
	
		

