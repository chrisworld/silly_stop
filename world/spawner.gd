extends Spatial

# man object
const Man1 = preload("res://models/man_v2/man_v2_group1.tscn")
const Man2 = preload("res://models/man_v2/man_v2_group2.tscn")

# materials
const group1_mat = preload("res://models/man_v2/mat/group1.material")
const group2_mat = preload("res://models/man_v2/mat/group2.material")

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
	var man;
	# spawn
	var direction_y = PI/2

	# group settings
	if group_id == 0:
		man = Man1.instance()
		
		# materials
		#man.get_node("actual_path/follower/Area/man_anim_v2/Armature/Skeleton/BowlerHat").mesh.surface_set_material(0, group1_mat)
		#man.get_node("actual_path/follower/Area/man_anim_v2/Armature/Skeleton/Tophead").mesh.surface_set_material(0, group1_mat)
		#man.get_node("actual_path/follower/Area/man_anim_v2/Armature/Skeleton/Guy").mesh.surface_set_material(0, group1_mat)
		
		# direction
		direction_y = PI/2

	elif group_id == 1:
		man = Man2.instance()

		# materials
		#man.actual_path/follower/Area/man_anim_v2/Armature/Skeleton/BowlerHat.mesh.surface_set_material(0, group2_mat)
		#man.get_node("actual_path/follower/Area/man_anim_v2/Armature/Skeleton/BowlerHat").mesh.surface_set_material(0, group2_mat)
		#man.get_node("actual_path/follower/Area/man_anim_v2/Armature/Skeleton/Tophead").mesh.surface_set_material(0, group2_mat)
		#man.get_node("actual_path/follower/Area/man_anim_v2/Armature/Skeleton/Guy").mesh.surface_set_material(0, group2_mat)

		# direction
		direction_y = 3*PI/2

	add_child(man)
	# get group		
	var group_node = get_child(group_id)

	# get path to spawn
	var spawn_path = group_node.get_child(0)

	# randomize
	rng.randomize()

	# random var along path [0, 1]
	var t = rng.randf()

	# init man
	man.init(group_id, path_id)

	# set translation
	man.translation = spawn_path.curve.interpolate_baked(t * spawn_path.curve.get_baked_length(), true)

	# direction

	# set rotation
	man.rotate_y(direction_y)


# spawn timer
func _on_Spawn_timer_timeout():
	
	var group_id = rng.randi_range(0, num_groups - 1)
	var path_id = rng.randi_range(0, 1)
	spawn_man(group_id, path_id)
