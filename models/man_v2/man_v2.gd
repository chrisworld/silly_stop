extends Spatial

export var group_id = 0
export var path_id = 0
export var max_speed = 0.15

# signal
signal collision_of_man
signal man_survived

# actual speed of man
var speed

# animation
var anim_tree

# follow path flag
var follow_path = true

# init
func init(_group_id, _path_id):

	# set
	group_id = _group_id
	path_id = _path_id

	# get path to follow
	$actual_path.curve = $path_container.get_child(path_id).curve
	
	# get anim tree
	anim_tree = $actual_path/follower/Area/man_anim_v2/AnimationTree

	# set anim active
	anim_tree.active = true


# ready
func _ready():
	
	# connect signals
	connect("collision_of_man", get_tree().get_root().find_node("world", true, false), "on_collision_of_man")
	connect("man_survived", get_tree().get_root().find_node("world", true, false), "on_man_survived")
	
	# get path to follow
	$actual_path.curve = $path_container.get_child(path_id).curve
	
	# get anim tree
	anim_tree = $actual_path/follower/Area/man_anim_v2/AnimationTree

	# set anim active
	anim_tree.active = true
	
	# set speed
	speed = max_speed
	
	

# update
func _process(delta):
	if $DeathTimer.time_left != 0:
		$actual_path/follower/Area/man_anim_v2/Armature/Skeleton/BowlerHat.translate(Vector3(0, delta * 10, 0))
		$actual_path/follower/Area/man_anim_v2/Armature/Skeleton/Tophead.translate(Vector3(0, delta * 10, 0))

	# update position on path
	if follow_path:
		
		# speed control
		if Input.is_action_pressed("group1_action"):
			if group_id == 0:
				speed = 0
				
		elif Input.is_action_pressed("group2_action"):
			if group_id == 1:
				speed = 0
		else:
			speed = max_speed
		
		# get position along the line
		var t0 = $actual_path/follower.get_unit_offset()
		
		# update on the path
		var t = t0 + speed * delta
		
		

		
		# end of path reached
		if t >= 1:

			# emit signal
			emit_signal("man_survived")

			# freeze
			freeze()

			# death timer
			$DeathTimer.start()
			
		else:
			# update path following
			$actual_path/follower.set_unit_offset(t)


# freeze the man
func freeze():
	
	# stop anim
	anim_tree.active = false

	# stop following the path
	follow_path = false

	# death timer
	$DeathTimer.start()


# something entered area
func _on_Area_area_entered(area):
	
	$actual_path/follower/Area/man_anim_v2/Dustcloud.restart()
	# emit signal
	emit_signal("collision_of_man")
	
	# freeze
	freeze()


# destroy
func _on_DeathTimer_timeout():
	queue_free()
