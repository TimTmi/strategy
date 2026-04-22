class_name Map extends NavigationRegion2D


@export_group("Wall auto-generation")
@export var auto_generate_walls: bool = true
@export var expand: int = 2
@export_group("References")
@export var floor_layer: TileMapLayer
@export var walls_layer: TileMapLayer



func _ready() -> void:
	if auto_generate_walls:
		_generate_walls_from_floor(
			func(cell: Vector2i) -> bool:
				return floor_layer.get_cell_source_id(cell) == -1 \
				or floor_layer.get_cell_source_id(cell + Vector2i.LEFT) == -1 \
				or floor_layer.get_cell_source_id(cell + Vector2i.RIGHT) == -1
		)

func has_point(point: Vector2) -> bool:
	var nav_polygon: NavigationPolygon = navigation_polygon
	if not nav_polygon:
		return false

	var vertices = nav_polygon.vertices
	for i in range(nav_polygon.get_polygon_count()):
		var indices = nav_polygon.get_polygon(i)
		var poly_points = []
		for index in indices:
			poly_points.append(vertices[index])
		
		if is_point_in_polygon(point, poly_points):
			return true
	
	return false

func is_point_in_polygon(point: Vector2, vertices: Array) -> bool:
	var inside = false
	var j = vertices.size() - 1
	for i in range(vertices.size()):
		if ((vertices[i].y > point.y) != (vertices[j].y > point.y)) and \
			(point.x < (vertices[j].x - vertices[i].x) * (point.y - vertices[i].y) / (vertices[j].y - vertices[i].y) + vertices[i].x):
			inside = not inside
		j = i
	return inside

func _generate_walls_from_floor(predicate: Callable) -> void:
	var used_rect: Rect2i = floor_layer.get_used_rect().grow(expand)
	var wall_cells: Array[Vector2i]
	
	for i: int in range(used_rect.position.x, used_rect.position.x + used_rect.size.x):
		for j: int in range(used_rect.position.y, used_rect.position.y + used_rect.size.y):
			var cell := Vector2i(i, j)
			if predicate.call(cell):
				walls_layer.set_cell(cell)
				wall_cells.append(cell)
	
	walls_layer.set_cells_terrain_connect(wall_cells, 0, 0)
