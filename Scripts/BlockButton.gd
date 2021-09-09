extends TextureButton


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var ButtonAnimation = get_normal_texture()


# Called when the node enters the scene tree for the first time.
func _ready():
	ButtonAnimation.set_current_frame(15)

func _pressed():
	if ButtonAnimation.get_current_frame() == 15:
		ButtonAnimation.set_current_frame(0)
	else:
		ButtonAnimation.set_current_frame(ButtonAnimation.get_current_frame()+1)
