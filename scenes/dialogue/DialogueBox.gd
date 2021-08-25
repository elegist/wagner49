extends Control

var options_scene = load("res://scenes/dialogue/Option.tscn")

onready var story = $Story

#func _ready() -> void:
#	load_story("res://stories/test.json")
#
#func _process(_delta: float) -> void:
#	if Input.is_action_just_pressed("ui_accept") && !story.get_HasChoices():
#		continue_and_display_story()

func load_story(story_file):
	story.InkFile = load(story_file)
	story.LoadStory()

func continue_and_display_story():
	story.Continue()
	$RichTextLabel.bbcode_text = story.get_CurrentText()
	$Tween.interpolate_property($RichTextLabel, "percent_visible", 0, 1, 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()
	if(story.get_HasChoices()):
		for choice in story.get_CurrentChoices():
			var option = options_scene.instance()
			option.get_node("Button").text = choice
			$VBoxContainer.add_child(option)
