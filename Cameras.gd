extends Node

@onready var cameras = get_children()
@onready var current_camera = 0;
@onready var next_camera = 0;

# Called when the node enters the scene tree for the first time.
func _ready():
	print(cameras)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("ui_accept"):
		if CameraTransition.in_transition: return
		
		if current_camera == 0:
			next_camera = 1
		else:
			next_camera = 0
			
		CameraTransition.transition_camera3D(cameras[current_camera], cameras[next_camera], 5)
		current_camera = next_camera
