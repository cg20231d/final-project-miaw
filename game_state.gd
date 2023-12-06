extends Node

var in_dialogue: bool = false
var keyframes = []
var Dialogue = preload("res://Dialogue.gd")
const keyframes_tolerance = 0.05
var selected_keyframe = -1
var amount_correct = 0
var is_correct = false

func _ready():
	DialogueManager.dialogue_ended.connect(_dialogue_ended)
	keyframes.append(Dialogue.new("q123", 3))
	keyframes.append(Dialogue.new("q45", 6))
	keyframes.append(Dialogue.new("q67", 9))
	keyframes.append(Dialogue.new("q89", 12))
	keyframes.sort()
	print(keyframes)

func update_closest_keyframe(time: float):
	var closest_dist = INF
	var dist = 0
	for index in keyframes.size():
		dist = abs(time - keyframes[index].keyframe)
		if dist <= keyframes_tolerance:
			selected_keyframe = index
			return
	selected_keyframe = -1
	return
	
func current_keyframe():
	if selected_keyframe == -1 or keyframes[selected_keyframe].completed == true:
		return null
	
	return keyframes[selected_keyframe]
	
func mark_correct():
	if selected_keyframe == -1 or keyframes[selected_keyframe].completed == true:
		return null
	
	amount_correct += 1
	is_correct = true
	
func _dialogue_ended(Dialogue :Resource):
	print(amount_correct)
	keyframes[selected_keyframe].completed = true
	in_dialogue = false
