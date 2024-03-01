extends RigidBody3D

@onready var explosion_audio: AudioStreamPlayer3D = $ExplosionAudio
@onready var success_audio: AudioStreamPlayer3D = $SuccessAudio
@onready var rocket_audio: AudioStreamPlayer3D = $RocketAudio
@onready var booster_particles: GPUParticles3D = $BoosterParticles
@onready var right_booster_particles: GPUParticles3D = $RightBoosterParticles
@onready var left_booster_particles: GPUParticles3D = $leftBoosterParticles





# The amount of vertical force to apply when the player presses the "boost" action.
@export_range(750, 2000) var Thrust: float = 1000.0
# The amount of torque to apply when turning.
@export_range(1, 250) var Torque: float = 100

# Flag to check if a scene transition is happening.
var is_transitioning: bool = false

func _ready() -> void:
	print("test ready")
	pass 

# `_process` function is called every frame, 'delta' is the time elapsed since the previous frame.
func _process(delta: float) -> void:
		
	# Apply vertical force if the "boost" action is pressed.
	if Input.is_action_pressed("boost"):
		
		booster_particles.emitting = true
		
		if rocket_audio.playing == false : 
			rocket_audio.play()
	
		apply_central_force(basis.y * delta * Thrust)
	else: 
		booster_particles.emitting = false
		rocket_audio.stop()
	
	
	if Input.is_action_pressed("turn_right"):
		right_booster_particles.emitting = true 
		apply_torque(Vector3(0,0,Torque * delta))
	else:
		right_booster_particles.emitting = false
	
	if Input.is_action_pressed("turn_left"):
		left_booster_particles.emitting = true 
		apply_torque(Vector3(0,0,-Torque * delta))
	else: 
		left_booster_particles.emitting = false
	
	if Input.is_action_pressed("ui_down"):
		apply_central_force(basis.y * delta * -Thrust)

func _on_body_entered(body: Node)-> void:
	if not is_transitioning:
		# Check if the body is part of the "Goal" group, start landing sequence.
		if "Goal" in body.get_groups():
			print(body)
			landed_sequence(body.file_path)
		
		# Check if the body is part of the "Failed" group, start crash sequence.
		if "Failed" in body.get_groups():
			crash_sequence()

func crash_sequence() -> void:
	print("Kaboom")
	
	explosion_audio.play(2.5)
	
	# Disable further processing to stop the character's movement.
	set_process(false)
	# Set flag for scene transition.
	is_transitioning = true

	# Create a tween to delay before retrying the scene.
	var tween = create_tween()
	tween.tween_interval(1.5)
	# Set the callback to reload the current scene after the interval.
	tween.tween_callback(get_tree().reload_current_scene)

func landed_sequence(next_level_file: String) -> void:
	print("Landed")
	
	success_audio.play()

	# Create a tween to delay the transition to the next level.
	var tween = create_tween()
	tween.tween_interval(1.5)
	# Set the callback to change to the next level scene after the interval.
	# 'bind' is used to pass 'next_level_file' to 'change_scene_to_file'.
	tween.tween_callback(get_tree().change_scene_to_file.bind(next_level_file))

