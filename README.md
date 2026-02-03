# Original Godot Forums Reply:

Hey,
I've managed to replicate your issue and solve this, perhaps in a more appropriate way.
I've used a shapecast in the shape of a cilinder, placed in inside the character bean, increased it's radius and decreased the height (optional) and created a custom `is_on_wall_only() -> bool` method to detect this using the shapecast.
![image|354x500, 50%](https://forum.godotengine.org/uploads/default/original/3X/c/f/cffc134402ca51eb5435b4bdc1592c399daeb283.png) ![image|261x202, 100%](https://forum.godotengine.org/uploads/default/original/3X/6/4/64b6d154274a497312df15ff11fc58ed535f6180.png) ![image|211x500](https://forum.godotengine.org/uploads/default/original/3X/3/1/317b37c27b8d7b1485674de20a5e21bd2639e1a7.png)
I made an `@export` for my OnWallShapecast (but that's not necessary):
```gdscript
@export var wall_shapecast: ShapeCast3D;
```
And made custom methods for detecting whether the player is on the wall (not overrides to not make the engine confused):
```gdscript
func custom_is_on_wall() -> bool:
	return wall_shapecast.is_colliding();


func custom_is_on_wall_only() -> bool:
	return !is_on_floor() and !is_on_ceiling() and custom_is_on_wall()
```

and then in your logic, I just replaced the call, and now it works:

```gdscript
[...]

	# handle state
	if custom_is_on_wall_only():
		currentState = State.Wall
	elif is_on_floor():
		currentState = State.Floor
	else:
		currentState = State.Air

	state_signal.emit(currentState)
	
	move_and_slide()
```

Here's a video of how it works:
https://youtu.be/3rf63SJxpyw
