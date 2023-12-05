extends Node

var in_dialogue: bool = false
var keyframes = []
const keyframes_tolerance = 0.3
var selected_keyframe = -1

func _ready():
	keyframes.append({"dialogue": "start", "keyframe": 2, "completed": false})
	keyframes.append({"dialogue": "start", "keyframe": 4, "completed": false})
	keyframes.sort()
	
	print(keyframes)

func update_closest_keyframe(time: float):
	
	var closest_dist = INF
	var dist = 0
	for index in keyframes.size():
		dist = abs(time - keyframes[index]["keyframe"])
		print(dist)
		if dist <= keyframes_tolerance:
			selected_keyframe = index
			return
	selected_keyframe = -1
	return
	
func current_keyframe():
	if selected_keyframe == -1 or keyframes[selected_keyframe]["completed"] == true:
		return null
	
	return keyframes[selected_keyframe]
	
func mark_completed():
	keyframes[selected_keyframe]["completed"] = true
	in_dialogue = false
