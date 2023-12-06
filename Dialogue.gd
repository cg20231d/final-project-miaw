extends Node

class_name Dialogue

var dialogue_name :String
var keyframe :float
var completed :bool
var answer :int
var is_correct :bool

func _init(dialogue_name :String, keyframe :float, completed :bool = false, is_correct :bool = false):
	self.dialogue_name = dialogue_name
	self.keyframe = keyframe
	self.answer = answer
	self.completed = completed
	self.is_correct = is_correct
