extends Button


# Called when the node enters the scene tree for the first time.
func _ready():
	connect("pressed", self, "_button_pressed")
	pass # Replace with function body.


func _button_pressed():
	print("Hallo")
	get_tree().change_scene("res://world/world.tscn")
