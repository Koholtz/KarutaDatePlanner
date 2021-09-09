extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var BlockButton = load("res://Scenes/BlockButton.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	for x in range(5):
		for y in range(7):
			var ThisButton = BlockButton.instance()
			add_child(ThisButton, true)
			ThisButton.rect_global_position = Vector2(x*80+32, y*80+32)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass



func _on_StartButton_button_down():
	var Blocks = get_children()	
	for r in Blocks:
		r.set_disabled(true)
