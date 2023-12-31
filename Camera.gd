extends Node

@onready var animation_player = $AnimationPlayer
const DIALOGUE = preload("res://dialogue/Dialogue.dialogue")
const speed_scale = 0.75
@onready var camera_3d = $Camera3D
@onready var spot_light_3d = $SpotLight3D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	spot_light_3d.transform = Transform3D(Basis.IDENTITY, camera_3d.to_global(Vector3(0.2, -0.5, 0)))
	spot_light_3d.rotation = camera_3d.rotation
	
	
	if not animation_player.is_playing():
		animation_player.play("camera_movement")
	
	if not GameState.in_dialogue and Input.is_action_pressed("ui_accept"):
		animation_player.speed_scale = speed_scale
		animation_player.advance(0)
	elif not GameState.in_dialogue and Input.is_action_pressed("ui_text_backspace"):
		animation_player.speed_scale = -speed_scale
		animation_player.advance(0)
	else:
		animation_player.pause()
	
	GameState.update_closest_keyframe(animation_player.current_animation_position)
	
	if not GameState.in_dialogue and GameState.current_keyframe() and not GameState.current_keyframe().completed:
		GameState.in_dialogue = true
		DialogueManager.show_example_dialogue_balloon(DIALOGUE, GameState.current_keyframe().dialogue_name)
		

