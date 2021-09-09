extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var Car = load("res://Scenes/Car.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	var StarterCar = Car.instance()
	add_child(StarterCar)
	StarterCar.rect_global_position = Vector2(198, 558)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass




func _on_StartButton_button_down():
	var Cars = get_children()
	for c in Cars:
		c.set_disabled(true)
		c.do_action()
