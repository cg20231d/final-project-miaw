extends Node

var in_dialogue: bool = false
var keyframes = []
var Dialogue = preload("res://Dialogue.gd")
const keyframes_tolerance = 0.3
var selected_keyframe = -1
var amount_correct = 0

func _ready():
	DialogueManager.dialogue_ended.connect(_dialogue_ended)
	keyframes.append(Dialogue.new("start", 4, 1))
	keyframes.append(Dialogue.new("start", 2, 1))
	keyframes.sort()
	
	print(keyframes)

func update_closest_keyframe(time: float):
	var closest_dist = INF
	var dist = 0
	for index in keyframes.size():
		dist = abs(time - keyframes[index].keyframe)
		print(dist)
		if dist <= keyframes_tolerance:
			selected_keyframe = index
			return
	selected_keyframe = -1
	return
	
func current_keyframe():
	if selected_keyframe == -1 or keyframes[selected_keyframe].completed == true:
		return null
	
	return keyframes[selected_keyframe]
	
func save_answer(ans :int):
	if selected_keyframe == -1 or keyframes[selected_keyframe].completed == true:
		return
		
	if(ans == keyframes[selected_keyframe].answer):
		amount_correct += 1
		keyframes[selected_keyframe].is_correct = true
	else:
		keyframes[selected_keyframe].is_correct = false
	
	keyframes[selected_keyframe].completed = true
	
func _dialogue_ended(Dialogue :Resource):
	in_dialogue = false
