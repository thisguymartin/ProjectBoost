extends AnimatableBody3D

@export var destination: Vector3 = Vector3(0, 6, 0)
@export var duration: float = 1
@export var speed: float = 3

func _ready() -> void:
	var tween = create_tween()
	tween.set_loops()
	tween.set_speed_scale(speed)
	
	tween.set_trans(Tween.TRANS_EXPO)
	
	tween.tween_property(self, "global_position", global_position + destination, duration)
	tween.tween_property(self, "global_position", global_position, duration)
	

func _process(delta: float) -> void:
	var tween = create_tween()

