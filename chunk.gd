extends CSGBox3D
class_name Chunk

# Render range in tiles
# Used for spawning and despawning tiles
var render_range = 3
var tile_size = 100

# Formatting like this so it would be visually understandable where neighbours are positioned
var neighbours : Array[Chunk] = [
	null, null, null,
	null,       null,
	null, null, null
]


