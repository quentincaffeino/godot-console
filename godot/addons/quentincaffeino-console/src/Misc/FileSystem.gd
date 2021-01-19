extends Reference

var _console

var fs = {}
var cwd = "/root/"

# inode/mft_entry list
var inode = {}
# data entry list
var data = {0:{data:"placeholder"}}
# data pointer for figuring out cwd
var pointer = 0


func _init(console):
	self._console = console
	
	# initialize filesystem
	create_fs()
	
	Console.add_command('pwd', self, 'pwd')\
		.set_description('Print Working Directory')\
		.register()
	Console.add_command('cd', self, 'cd')\
		.set_description('Change directory')\
		.add_argument('directory', TYPE_STRING)\
		.register()
	Console.add_command('ls', self, 'ls')\
		.set_description('List directory')\
		.register()
	Console.add_command('cat', self, 'cat')\
		.set_description('Print out file content')\
		.add_argument('filename', TYPE_STRING)\
		.register()
	Console.add_command('touch', self, 'touch')\
		.set_description('Create a file')\
		.add_argument('filename', TYPE_STRING)\
		.register()
	Console.add_command('mkdir', self, 'mkdir')\
		.set_description('Creates a directory')\
		.add_argument('name', TYPE_STRING)\
		.register()
	Console.add_command('rm', self, 'rm')\
		.set_description('Removes a file')\
		.add_argument('filename', TYPE_STRING)\
		.register()

		
func pwd():
	Console.write_line(cwd)
	Console.write("inode pointer at: ")
	Console.write(self.pointer)

func cd(arg: String):
	var cwd_list = self.cwd.split("/", false)
	if arg == "..":
		cwd_list.remove(cwd_list.size()-1)
	elif arg[0] == "/":
		if pointer != find_inode_entry(arg):
			cwd_list = arg.split("/", false)
	else:
		if pointer != find_inode_entry(self.cwd+arg):
			var arg_list = arg.split("/", false)
			cwd_list.append_array(arg_list)
	var cwd = "/"+cwd_list.join("/")+"/"
	if self.inode[find_inode_entry(cwd)]._directory:
		self.cwd = cwd
		if self.cwd == "//": self.cwd = "/"
		self.pointer = find_inode_entry(self.cwd)
	else:
		Console.write_line(cwd+" is not a directory.")
	
func ls():
	var ls_return = ""
	for file in self.inode[self.pointer].child_nodes:
		ls_return += " " + file.name
	Console.write_line(ls_return)

func cat(file: String):
	if self.inode[find_inode_entry(file)]._directory:
		Console.write_line("Can't ouput a directory. Check your spelling.")
	else:
		var raw_data = self.data[self.inode[find_inode_entry(file)]._data_entry]
		Console.write_line(raw_data)
		
func touch(name: String):
	self.inode[self.pointer].add_child_node(name, 0, false, self.inode)
func mkdir(name: String):
	self.inode[self.pointer].add_child_node(name, 0, true, self.inode)
func rm(name: String):
	self.inode[self.pointer].remove_child_node(name, self.inode)

func create_fs():
	var root = node_entry.new("/", 0, -1, true,0)
	self.inode[0] = root
	root.add_child_node("etc", 0, true, self.inode)
	root.add_child_node("root", 0, true, self.inode)
	root.add_child_node("home", 0, true, self.inode)
	var etc = inode[find_inode_entry("/etc")]
	etc.add_child_node("passwd", 0, false, self.inode)
	var passwd = inode[find_inode_entry("/etc/passwd")]
	passwd.add_data("root:x:0:0:root:/root:{unkown-WIP}", self.data)
	self.pointer = find_inode_entry(self.cwd)

func find_inode_entry(query: String):
	# the query is linux directory structure. IE. '/root/etc/passwd'
	var query_loop = query.split("/", false)
	var node = self.inode[0]
	for name in query_loop:
		for child_node in node.child_nodes:
			if child_node.name == name:
				node = inode[child_node._inode_entry]
				var inode_entry = node._inode_entry
	return node._inode_entry

class node_entry:
	var name: String
	var _permission: int
	var _owner: int
	var _parent_node: int
	var _directory: bool
	var child_nodes = []
	var _inode_entry: int
	var _data_entry: int
	
	func _init(name: String, _owner: int, _parent_node: int, _directory: bool, _inode_entry: int):
		self.name = name
		self._owner = _owner
		self._parent_node = _parent_node
		self._directory = _directory
		self._inode_entry = _inode_entry
	
	func add_child_node(name: String, _owner: int, _directory: bool, inode: Dictionary):
		var duplicate_node = false
		for child_node in self.child_nodes:
			if child_node.name == name:
				duplicate_node = true
		if self._directory == false and _directory==true:
			Console.write_line(self.name+" is not a directory. Can't create '"+name+"'.")
		elif duplicate_node:
			Console.write_line(name+" already exist.")
		else:
			var inode_entry = inode.keys()[-1] + 1
			self.child_nodes.append({
				"name":name, 
				"_owner":_owner, 
				"_parent_node":self._inode_entry, 
				"_directory":_directory, 
				"_inode_entry":inode_entry
			})
			inode[inode_entry] = node_entry.new(name, _owner, self._inode_entry, _directory, inode_entry)
	
	func remove_child_node(name: String, inode: Dictionary):
		for child_node in self.child_nodes:
			if child_node.name == name:
				inode.erase(child_node._inode_entry)
				self.child_nodes.erase(child_node)
	
	func add_data(text: String, data_dict):
		self._data_entry = data_dict.keys()[-1] + 1
		data_dict[self._data_entry] = text
	
	func info():
		return {
			"name":self.name, 
			"_permission":self._permission, 
			"_owner":self._owner, 
			"_parent_node":self._parent_node, 
			"_directory":self._directory, 
			"_inode_entry":self._inode_entry
		}
