extends Node2D

func _ready() -> void:
	$Control/DialogueBox.load_story("res://stories/test.json")

func _process(delta: float) -> void:
	if $Paths/Path1/Player.dialogue_started:
		$Control/DialogueBox.visible = true
		if Input.is_action_just_pressed("next") && !$Control/DialogueBox.story.get_HasChoices():
			$Control/DialogueBox.continue_and_display_story()
	else:
		$Control/DialogueBox.visible = false
