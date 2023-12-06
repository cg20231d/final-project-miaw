extends Node

@onready var animation_player = $AnimationPlayer
const DIALOGUE = preload("res://dialogue/Dialogue.dialogue")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not animation_player.is_playing():
		animation_player.play("camera_movement")
	
	if not GameState.in_dialogue and Input.is_action_pressed("ui_accept"):
		animation_player.speed_scale = 1
		animation_player.advance(0)
	elif not GameState.in_dialogue and Input.is_action_pressed("ui_text_backspace"):
		animation_player.speed_scale = -1
		animation_player.advance(0)
	else:
		animation_player.pause()
	
	GameState.update_closest_keyframe(animation_player.current_animation_position)
	print(GameState.current_keyframe())
	
	if not GameState.in_dialogue and GameState.current_keyframe() and not GameState.current_keyframe().completed:
		GameState.in_dialogue = true
		DialogueManager.show_example_dialogue_balloon(DIALOGUE, GameState.current_keyframe().dialogue_name)
		

