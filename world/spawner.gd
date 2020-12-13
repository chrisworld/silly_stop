extends Spatial

# man object
const Man1 = preload("res://models/man_v2/man_v2_group1.tscn")
const Man2 = preload("res://models/man_v2/man_v2_group2.tscn")

# materials
const group1_mat = preload("res://models/man_v2/mat/group1.material")
const group2_mat = preload("res://models/man_v2/mat/group2.material")

# max angle change
export var d_phi_max = PI/6

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

	# path settings
	if path_id == 0:

		# hat
		man.get_node("actual_path/follower/Area/man_anim_v2/Armature/Skeleton/BowlerHat").visible = true
		man.get_node("actual_path/follower/Area/man_anim_v2/Armature/Skeleton/Tophead").visible = false

	elif path_id == 1:

		# hat
		man.get_node("actual_path/follower/Area/man_anim_v2/Armature/Skeleton/BowlerHat").visible = false
		man.get_node("actual_path/follower/Area/man_anim_v2/Armature/Skeleton/Tophead").visible = true

	add_child(man)
	# get group		
	var group_node = get_child(group_id)

	# get path to spawn
	var spawn_path = group_node.get_child(0)

	# randomize
	rng.randomize()

	# random spawn location along path [0, 1]
	var t = rng.randf()

	# random rotation
	var d_phi = rng.randf_range(-1.0, 1.0) * d_phi_max

	# init man
	man.init(group_id, path_id)

	# set translation
	man.translation = spawn_path.curve.interpolate_baked(t * spawn_path.curve.get_baked_length(), true)

	# set rotation
	man.rotate_y(direction_y + d_phi)


# spawn timer
func _on_Spawn_timer_timeout():
	
	# group id
	var group_id = rng.randi_range(0, num_groups - 1)

	# path id
	var path_id = rng.randi_range(0, 1)

	# spawn
	spawn_man(group_id, path_id)
