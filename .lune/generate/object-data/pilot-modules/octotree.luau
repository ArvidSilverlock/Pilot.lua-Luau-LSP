export type Octree<T> = {
	ClearAllNodes: (self: Octree<T>) -> (),
	GetAllNodes: (self: Octree<T>) -> { Node<T> },
	ForEachNode: (self: Octree<T>) -> () -> Node<T>?,
	FindFirstNode: (self: Octree<T>, object: T) -> Node<T>?,
	CountNodes: (self: Octree<T>) -> number,
	CreateNode: (self: Octree<T>, position: Vector3, object: T) -> Node<T>,
	RemoveNode: (self: Octree<T>, node: Node<T>) -> (),
	ChangeNodePosition: (self: Octree<T>, node: Node<T>, position: Vector3) -> (),
	SearchRadius: (self: Octree<T>, position: Vector3, radius: number) -> { Node<T> },
	ForEachInRadius: (self: Octree<T>, position: Vector3, radius: number) -> () -> Node<T>?,
	GetNearest: (self: Octree<T>, position: Vector3, radius: number, maxNodes: number?) -> { Node<T> },
}

type OctreeInternal<T> = Octree<T> & {
	Size: number,
	Regions: { Region<T> },
	_getRegion: (self: OctreeInternal<T>, maxLevel: number, position: Vector3) -> Region<T>,
}

export type Region<T> = {
	Center: Vector3,
	Size: number,
	Radius: number,
	Regions: { Region<T> },
	Parent: Region<T>?,
	Level: number,
	Nodes: { Node<T> }?,
}

export type Node<T> = {
	Position: Vector3,
	Object: T,
}

type NodeInternal<T> = Node<T> & {
	Region: Region<T>?,
}
return require("octotree") :: {
	new: <T>(topRegionSize: number?) -> Octree<T>,
}
