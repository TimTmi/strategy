class_name Map extends NavigationRegion2D



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
