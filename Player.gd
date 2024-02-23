extends RigidBody3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	print("test ready")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:

	if Input.is_action_pressed("ui_accept"):
		apply_central_force(Vector3.UP * delta * 1000.0)

