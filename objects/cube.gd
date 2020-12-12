extends Spatial

func _on_Area_area_entered(area):
	print("entered: ", area)
	
	
export var path_id = 0
export var speed = 10

var actual_path
var path_container

# Called when the node enters the scene tree for the first time.
func _ready():
	
	actual_path = get_node("cube_path")
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):

	# update position on path
	actual_path.get_child(0).set_offset(actual_path.get_child(0).get_offset() + speed * delta)
