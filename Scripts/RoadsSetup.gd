extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var RoadButton = load("res://Scenes/RoadButton.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	for xh in range(5):
		for yh in range(8):
			var ThisButton = RoadButton.instance()
			add_child(ThisButton)
			ThisButton.rect_global_position = Vector2(xh*80+40, yh*80)
			
			if yh == 0 or yh == 7:
				ThisButton.set_script(null)
			var RoadSprite = ThisButton.get_child(0)
			RoadSprite.set_rotation_degrees(90)
			RoadSprite.set_position(Vector2(16, 0))

	for xv in range(6):
		for yv in range(7):
			var ThisButton = RoadButton.instance()
			add_child(ThisButton)
			ThisButton.rect_global_position = Vector2(xv*80, yv*80+40)
			
			if xv == 0 or xv == 5:
				ThisButton.set_script(null)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_StartButton_button_down():
	var Roads = get_children()
	for r in Roads:
		r.set_disabled(true)
