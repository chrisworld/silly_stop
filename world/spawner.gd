extends Spatial

# man object
const Man = preload("res://models/man.tscn")

# randomizer
var rng = RandomNumberGenerator.new()

# number of groups
var num_groups


# ready
func _ready():

	# set number of groups
	num_groups =  len(get_children()) - 1

	# spawn first man
	spawn_man(0, 0)



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

	man.init(group_id, path_id)

	# set translation
	man.translation = spawn_path.curve.interpolate_baked(t * spawn_path.curve.get_baked_length(), true)

	var direction_y = PI/2

	if group_id == 1:
		direction_y = 3*PI/2

	# set rotation
	man.rotate_y(direction_y)


# spawn timer
func _on_Spawn_timer_timeout():
	
	var group_id = rng.randi_range(0, num_groups - 1)
	var path_id = rng.randi_range(0, 1)
	spawn_man(group_id, path_id)
