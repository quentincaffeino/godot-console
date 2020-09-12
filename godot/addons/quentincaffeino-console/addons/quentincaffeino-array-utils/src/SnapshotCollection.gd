
extends 'Collection.gd'


# @param  Dictionary
var _snapshot


# Creates snapsot of the collection
func takeSnapshot():  # SnapshotCollection
	self._snapshot = self._collection.duplicate()
	return self


# Returns last snapshot
func getShapshot():  # Dictionary
	return self._snapshot if self._snapshot else self._collection.duplicate()
