extends Spatial

export var path_id = 0
export var speed = 10

var anim_tree
var follow_path = true


# ready
func _ready():

	# get path to follow
	$actual_path.curve = $path_container.get_child(path_id).curve
	
	# get anim tree
	anim_tree = $actual_path/follower/Area/man_anim/AnimationTree

	# set anim active
	anim_tree.active = true
	

# update
func _process(delta):

	# update position on path
	if follow_path:
		$actual_path/follower.set_offset($actual_path/follower.get_offset() + speed * delta)


# something entered area
func _on_Area_area_entered(area):
	print("stop")
	anim_tree.active = false
	follow_path = false
	
