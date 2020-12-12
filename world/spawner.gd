extends Spatial

# man object
const Man = preload("res://models/man.tscn")

# randomizer
var rng = RandomNumberGenerator.new()


# ready
func _ready():

	# group id
	var group_id = 0
	var path_id = 0

	# spawn
	spawn_man(group_id, path_id)



# spawn a man according his type
func spawn_man(group_id, path_id):

	# spawn
	var man = Man.instance()
	add_child(man)
	
	# get group		
	var group_node = get_child(group_id)

	# get path to spawn
	var spawn_path = group_node.get_child(0)

	# randomize
	rng.randomize()

	# random var along path [0, 1]
	var t = rng.randf()

	# set translation
	man.translation = spawn_path.curve.interpolate_baked(t * spawn_path.curve.get_baked_length(), true)

	# set rotation
	man.rotate_y(PI/2)


# spawn timer
func _on_Spawn_timer_timeout():
	
	spawn_man(0, 0)
