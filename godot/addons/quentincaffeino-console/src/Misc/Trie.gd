
extends Reference


# @var  TrieNode
var _root


# Trie data structure class
func _init():
	self._root = TrieNode.new()


# If not present, inserts key into trie.
# If the key is prefix of trie node, just marks leaf node.
# @param    String   key
# @param    Command  command
# @returns  void
func insert(key, command):
	var current_node = self._root

	var length = len(key)
	for level in range(length):
		var index = key[level]

		# if current character is not present
		if not current_node.has_child(index):
			current_node.initialize_child_at(index)

		current_node = current_node.get_child(index)

	if current_node.command:
		return

	current_node.command = command


# Search key in the trie.
# Returns true if key presents in trie, else false.
# @param    String  key
# @returns  bool
func has(key):
	return !!self.get(key)


# Search key in the trie.
# Returns Command if key presents in trie, else null.
# @param    String  key
# @returns  Command|null
func get(key):
	var current_node = self._root

	var length = len(key)
	for level in range(length):
		var index = key[level]

		if not current_node.has_child(index):
			return null

		current_node = current_node.get_child(index)

	return current_node.command



class TrieNode:

	# @var  Dictionary
	var _children

	# @var  Command|null
	var command


	# Trie node class
	func _init():
		self._children = {}
		self.command = null


	# @returns  Dictionary
	func get_children():
		return self._children


	# @param    int  index
	# @returns  bool
	func has_child(index):
		return index in self._children

	# @param    int  index
	# @returns  Dictionary
	func get_child(index):
		return self._children[index]

	# @param    int       index
	# @returns  void
	func initialize_child_at(index):
		self._children[index] = TrieNode.new()
