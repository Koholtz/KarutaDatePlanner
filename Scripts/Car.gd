extends TextureButton

onready var Arrow = get_node("Node2D/Arrow")
var Gas = 100
var Food = 50
var Drink = 50
var Fun = 75
var Time = 100
var Actions = []

var CarResource = load("res://Scenes/Car.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _pressed():
	Arrow.rotation_degrees = int(fmod(Arrow.rotation_degrees + 180, 360))

func return_actions(ActionsDone):
	print(Actions)
	print(Gas + Food + Drink + Fun)
	queue_free()

func do_block_action(block):
	var ActionCar = CarResource.instance()
	get_parent().add_child(ActionCar)
	ActionCar.rect_global_position = rect_global_position
	ActionCar.get_node("Node2D/Arrow").rotation_degrees = Arrow.rotation_degrees
	ActionCar.Actions = Actions
	ActionCar.Actions.append(block)
	
	if block.ButtonAnimation.get_current_frame() == 0:
		ActionCar.Gas = 100
		ActionCar.Food = Food - 4
		ActionCar.Drink = Drink - 6
		ActionCar.Fun = Fun - 8
		ActionCar.Time = Time - 4
	elif block.ButtonAnimation.get_current_frame() == 1 or block.ButtonAnimation.get_current_frame() == 2:
		ActionCar.Gas = Gas
		ActionCar.Food = Food + 56
		ActionCar.Drink = Drink - 6
		ActionCar.Fun = Fun - 8
		ActionCar.Time = Time - 4
	elif block.ButtonAnimation.get_current_frame() == 3:
		ActionCar.Gas = Gas
		ActionCar.Food = Food + 36
		ActionCar.Drink = Drink + 14
		ActionCar.Fun = Fun - 8
		ActionCar.Time = Time - 4
	elif block.ButtonAnimation.get_current_frame() == 4:
		ActionCar.Gas = Gas
		ActionCar.Food = Food + 16
		ActionCar.Drink = Drink + 14
		ActionCar.Fun = Fun + 32
		ActionCar.Time = Time - 4
	elif block.ButtonAnimation.get_current_frame() == 5 or block.ButtonAnimation.get_current_frame() == 6:
		ActionCar.Gas = Gas
		ActionCar.Food = Food - 4
		ActionCar.Drink = Drink + 54
		ActionCar.Fun = Fun - 8
		ActionCar.Time = Time - 4
	elif block.ButtonAnimation.get_current_frame() == 7:
		ActionCar.Gas = Gas
		ActionCar.Food = Food - 4
		ActionCar.Drink = Drink + 34
		ActionCar.Fun = Fun + 32
		ActionCar.Time = Time - 4
	elif block.ButtonAnimation.get_current_frame() == 8:
		ActionCar.Gas = Gas
		ActionCar.Food = Food - 4
		ActionCar.Drink = Drink - 6
		ActionCar.Fun = Fun + 92
		ActionCar.Time = Time - 4
	elif block.ButtonAnimation.get_current_frame() == 9:
		ActionCar.Gas = Gas
		ActionCar.Food = Food - 14
		ActionCar.Drink = Drink - 21
		ActionCar.Fun = Fun + 92
		ActionCar.Time = Time - 4
	elif block.ButtonAnimation.get_current_frame() == 10:
		ActionCar.Gas = Gas
		ActionCar.Food = Food - 4
		ActionCar.Drink = Drink - 6
		ActionCar.Fun = Fun + 52
		ActionCar.Time = Time - 4
	elif block.ButtonAnimation.get_current_frame() == 12:
		ActionCar.Gas = Gas
		ActionCar.Food = Food - 4
		ActionCar.Drink = Drink - 6
		ActionCar.Fun = Fun - 8
		ActionCar.Time = Time - 4
	elif block.ButtonAnimation.get_current_frame() == 13:
		ActionCar.Gas = Gas
		ActionCar.Food = Food - 4
		ActionCar.Drink = Drink - 6
		ActionCar.Fun = Fun - 8
		ActionCar.Time = Time - 4
	elif block.ButtonAnimation.get_current_frame() == 14:
		ActionCar.return_actions(ActionCar.Actions)
	else:
		print("A WILD BLOCK HAS APPEARED")
	
	ActionCar.do_action()

func do_action():
	#Check if the date failed
	if Gas < 1 or Food < 1 or Drink < 1 or Fun < 1:
		print(Actions)
		queue_free()

	#Check if the date succeded
	elif Time < 1:
		return_actions(Actions)

	#Makes sure everything is capped at 100
	if Gas > 100:
		Gas = 100
	if Food > 100:
		Food = 100
	if Drink > 100:
		Drink = 100
	if Fun > 100:
		Fun = 100

	#Do all the actions possible
	var Areas = Arrow.get_children()
	for a in Areas:
		var overlap = a.get_overlapping_areas()

		#Check if Area2D is overlapping other cars' Area2D and ignores them
		if overlap.size() > 1:
			var OverlapCopy = overlap
			var iteration = -1
			var IndexesToRemove = []
			for o in OverlapCopy:
				iteration = iteration + 1
				if o.get_owner().get_filename() == "res://Scenes/Car.tscn":
					IndexesToRemove.append(iteration)
			IndexesToRemove.invert()
			for i in IndexesToRemove:
				overlap.remove(i)

		#Check if each Area2D is overlapping only one button
		#If it doesn't overlap anything, it's ignored
		if overlap.size() > 1:
			print(a)
			print("ERROR MULTIPLE OVERLAPS")
		elif overlap.size() <1:
			continue
		else:
			var Button = overlap[0].get_owner()

			#Check if overlapping area is a Block
			#If it's a tree (or the airport, currently), it's ignored
			if Button.get_filename() == "res://Scenes/BlockButton.tscn":
				if Button.ButtonAnimation.get_current_frame() in [11, 15]:
					continue
				else:
					if Button in Actions:
						if Actions.find_last(Button) < (Actions.size() - 10) and not Button.ButtonAnimation.get_current_frame() in [8, 12, 13]:
							do_block_action(Button)
						else:
							continue
					else:
						do_block_action(Button)

			#Check if overlapping area is a Road
			#If it's a blocked road, it's ignored
			elif Button.get_filename() == "res://Scenes/RoadButton.tscn":
				if Button.get_children()[0].get_class() == "Sprite":
					if Button.get_children()[0].is_visible() == true:
						continue
					else:
						var ActionCar = CarResource.instance()
						get_parent().add_child(ActionCar)
						ActionCar.rect_global_position = Button.rect_global_position - Vector2(2,2)
						ActionCar.Actions = Actions

						if a == get_node("Node2D/Arrow/RoadRight"):
							ActionCar.get_node("Node2D/Arrow").rotation_degrees = int(fmod(Arrow.rotation_degrees + 90, 360))
						elif a == get_node("Node2D/Arrow/RoadLeft"):
							ActionCar.get_node("Node2D/Arrow").rotation_degrees = int(fmod(Arrow.rotation_degrees - 90, 360))
						elif a == get_node("Node2D/Arrow/RoadFront"):
							ActionCar.get_node("Node2D/Arrow").rotation_degrees = int(fmod(Arrow.rotation_degrees, 360))
						else:
							print("I DON'T  KNOW WHERE DO LOOK")

						ActionCar.Actions.append(int(fmod(Arrow.rotation_degrees, 360)))
						ActionCar.do_action()
				else:
					print("THIS SHOULD BE A SPRITE")
			else:
				print("A WILD POKEMON HAS APPEARED")
				print(Button.get_filename())
	queue_free()
