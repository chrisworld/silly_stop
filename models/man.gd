extends Spatial

export var path_id = 0
export var speed = 0.15

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
		
		# get position along the line
		var t0 = $actual_path/follower.get_unit_offset()
		
		# update on the path
		var t = t0 + speed * delta
		
		# end of path reached
		if t >= 1:
			freeze()
			
		else:
			# update path following
			$actual_path/follower.set_unit_offset(t)


# freeze the man
func freeze():

	# stop anim
	anim_tree.active = false

	# stop following the path
	follow_path = false


# something entered area
func _on_Area_area_entered(area):

	# freeze
	freeze()

	
