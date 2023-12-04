extends Node

@onready var animation_player = $AnimationPlayer

var keyframes = []
const keyframes_tolerance = 0.3

var selected_keyframe = -1

# Called when the node enters the scene tree for the first time.
func _ready():
	keyframes.append({"keyframe": 2})
	keyframes.append({"keyframe": 3})
	keyframes.sort()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not animation_player.is_playing():
		animation_player.play("camera_movement")
	
	if Input.is_action_pressed("ui_accept"):
		animation_player.speed_scale = 1
		animation_player.advance(0)
	elif Input.is_action_pressed("ui_text_backspace"):
		animation_player.speed_scale = -1
		animation_player.advance(0)
	elif Input.is_action_pressed("ui_focus_next"):
		DialogueManager.show_example_dialogue_balloon(load("res://dialogue/test.dialogue"), "start")
		return
	else:
		animation_player.pause()
	
	selected_keyframe = closest_keyframe(keyframes, animation_player.current_animation_position, keyframes_tolerance)
	
	if selected_keyframe == -1:
		print("No keyframe selected")
	else:
		print(keyframes[selected_keyframe])
		
func closest_keyframe(array: Array, value: float, tolerance: float = 0.2):
	var closest_dist = INF
	var dist = 0
	for index in keyframes.size():
		dist = abs(value - keyframes[index]["keyframe"])
		if dist <= tolerance:
			return index
	return -1
