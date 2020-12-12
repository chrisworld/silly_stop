extends Spatial

export var path_id = 0
export var speed = 10

var actual_path
var path_container

# ready
func _ready():
	
	actual_path = get_node("actual_path")
	path_container = get_node("path_container")

	# get path to follow
	actual_path.curve = path_container.get_child(path_id).curve
	

# update
func _process(delta):

	# update position on path
	actual_path.get_child(0).set_offset(actual_path.get_child(0).get_offset() + speed * delta)

	
# area enter
func _on_Area_area_entered(area):
	print("body entered: ", area)

	# halt time
	
	
	# destroy object

