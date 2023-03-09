extends Node
class_name Rect2Col

const RECT2COL_GROUP = "RECT2COL_fdasdkfjhskajd12"

static func collision_check(rootNode: Area2D, deltaPos: Vector2, nodeGroup: String = RECT2COL_GROUP) -> Node:
	
	var xform: Transform2D = Transform2D(0, deltaPos)
	var solidNodes: Array = rootNode.get_tree().get_nodes_in_group(nodeGroup)
	#print("FOUND ", solidNodes.size(), " ", nodeGroup)
	# get all solid objects
	for i in solidNodes.size():
		
		var node: Node = solidNodes[i]
		
		# ignore itself
		if node == rootNode:
			continue
		
		if node is Area2D:
			
			# Tilemap inside area
			var hasTileMap: bool = false
			
			for child in node.get_children():
				if child is TileMap:
					
					if !(child as TileMap).collision_use_parent:
						continue
						
					hasTileMap = true
					
					if AreaTileMapCollide(rootNode, child, xform, child.global_transform):
						return node
					
			if hasTileMap:
				continue
				
			# Normal area
			if AreaAreaCollide(rootNode, node, xform):
				return node
			
		elif node is TileMap:
			if AreaTileMapCollide(rootNode, node, xform, node.global_transform):
				return node
	
	return null

static func AreaTileMapCollide(nodeA: Area2D, tileMap: TileMap, xform: Transform2D, xformTileMap: Transform2D) -> bool:
	
	var shapeNode: Shape2D = null
	var shapeA: RectangleShape2D = null
	var shapeB: RectangleShape2D = RectangleShape2D.new()
	var xformA: Transform2D
	var xformCell: Transform2D
	
	# get tile map size                     # v-- workaround for edge contact
	shapeB.set_extents(tileMap.cell_size / 2 - Vector2.ONE * 0.1) 
	
	
	for idxOwnerA in nodeA.get_shape_owners():
		
		if nodeA.is_shape_owner_disabled(idxOwnerA):
			continue
		
		for idxShapeA in nodeA.shape_owner_get_shape_count(idxOwnerA):
			
			# only rectangle shapes allowed
			shapeNode = nodeA.shape_owner_get_shape(idxOwnerA, idxShapeA)
			if (!(shapeNode is RectangleShape2D)):
				continue
				
			shapeA = shapeNode as RectangleShape2D
			xformA = xform
			xformA.origin += nodeA.shape_owner_get_transform(idxOwnerA).origin
			
			# world to tilemap cords of 4 corners
			var nodeLocalPos = tileMap.to_local(xformA.origin)
			var cellPos = tileMap.world_to_map(nodeLocalPos)
			
			var cornerTopLeft  = xformA.origin + Vector2(-shapeA.extents.x, -shapeA.extents.y)
			#var cornerTopRight = xformA.origin + Vector2(shapeA.extents.x, -shapeA.extents.y)
			#var cornerBotLeft  = xformA.origin + Vector2(-shapeA.extents.x, shapeA.extents.y)
			var cornerBotRight = xformA.origin + Vector2(shapeA.extents.x, shapeA.extents.y)
	
			var areaStart = tileMap.world_to_map(tileMap.to_local(cornerTopLeft))
			var areaEnd   = tileMap.world_to_map(tileMap.to_local(cornerBotRight))
	
			# iterate cells in area
			for i in range(areaStart.x, areaEnd.x+1):
				for j in range(areaStart.y, areaEnd.y+1):
					var cell = tileMap.get_cell(i,j)
					#print("A ", i, " ", j)
					
					if cell == TileMap.INVALID_CELL:
						continue
						
					xformCell = xformTileMap
					xformCell.origin += tileMap.cell_size * (Vector2(i,j) + Vector2.ONE * 0.5)
					
					if (shapeA.collide(xformA, shapeB, xformCell)):
						return true
						
	return false
	
static func AreaAreaCollide(nodeA: Area2D, nodeB: Area2D, xform: Transform2D) -> bool:
	
	var shapeA: Shape2D = null
	var shapeB: Shape2D = null
	var xformA: Transform2D
	var xformB: Transform2D
	
	for idxOwnerA in nodeA.get_shape_owners():
		
		if nodeA.is_shape_owner_disabled(idxOwnerA):
			continue
					
		for idxShapeA in nodeA.shape_owner_get_shape_count(idxOwnerA):
			shapeA = nodeA.shape_owner_get_shape(idxOwnerA, idxShapeA).duplicate()
			xformA = xform
			xformA.origin += nodeA.shape_owner_get_transform(idxOwnerA).origin
			
			# workaround for edge contact
			if shapeA is RectangleShape2D:
				shapeA.set_extents(shapeA.extents - Vector2.ONE * 0.1)
				
			for idxOwnerB in nodeB.get_shape_owners():
				
				if nodeB.is_shape_owner_disabled(idxOwnerB):
					continue
				
				for idxShapeB in nodeB.shape_owner_get_shape_count(idxOwnerB):
					
					shapeB = nodeB.shape_owner_get_shape(idxOwnerB, idxShapeB)
					xformB = nodeB.global_transform
					xformB.origin += nodeB.shape_owner_get_transform(idxOwnerB).origin
					
					if (shapeA.collide(xformA, shapeB, xformB)):
						return true
						
	return false


