extends Node

@onready var camera_3d: Camera3D = $Camera3D

var in_transition: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	camera_3d.current = false

func transition_camera3D(from: Camera3D, to: Camera3D, duration: float = 1.0):
	if in_transition: return
	
	# Copy parameters of the first camera
	camera_3d.fov = from.fov
	camera_3d.cull_mask = from.cull_mask
	
	# Move transition camera to "from" camera position
	camera_3d.global_transform = from.global_transform
	
	camera_3d.current = true
	
	in_transition = true
	
	var tween = create_tween()
	tween.set_parallel(true)
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(camera_3d, "global_transform", to.global_transform, duration).from(camera_3d.global_transform)
	tween.tween_property(camera_3d, "fov", to.fov, duration).from(camera_3d.fov)
	
	await tween.finished
	
	to.current = true
	in_transition = false
	
