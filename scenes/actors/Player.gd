extends PathFollow2D

export var speed = 4
var path_index = 0
var can_talk = false
var can_move = true
var dialogue_started = false

onready var paths = get_tree().get_root().find_node("Paths", true, false)

func _process(_delta: float) -> void:
	if can_move:
		var move_direction = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
		var velocity = move_direction * speed
		
		offset += velocity
		
		if paths.get_child_count() > 1:
			if Input.is_action_just_pressed("move_forwards"):
				if path_index < paths.get_child_count() - 1:
					path_index += 1
					var new_parent = paths.get_child(path_index)
					get_parent().remove_child(self)
					new_parent.add_child(self)
			if Input.is_action_just_pressed("move_backwards"):
				if path_index > 0:
					path_index -= 1
					var new_parent = paths.get_child(path_index)
					get_parent().remove_child(self)
					new_parent.add_child(self)
		
		if move_direction < 0:
			$Sprite.flip_h = true
		elif move_direction > 0:
			$Sprite.flip_h = false
	
	if can_talk:
		if Input.is_action_just_pressed("talk"):
			can_move = false
			dialogue_started = true
	
	if !can_move:
		if Input.is_action_just_pressed("ui_cancel"):
				can_move = true
				dialogue_started = false


func _on_Area2D_area_entered(area: Area2D) -> void:
	if area.name == "wagner_dialogue":
		can_talk = true


func _on_Area2D_area_exited(area: Area2D) -> void:
	if area.name == "wagner_dialogue":
		can_talk == false
