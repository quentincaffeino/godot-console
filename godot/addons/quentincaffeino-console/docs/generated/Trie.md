<!-- Auto-generated from JSON by GDScript docs maker. Do not edit this document directly. -->

# Trie

**Extends:** [Reference](../Reference)

## Description

## Method Descriptions

### insert

```gdscript
func insert(key: String, command: Command): void
```

If not present, inserts key into trie.
If the key is prefix of trie node, just marks leaf node.

### has

```gdscript
func has(key: String): bool
```

Search key in the trie.
Returns true if key presents in trie, else false.

### get

```gdscript
func get(key: String): Command|null
```

Search key in the trie.
Returns Command if key presents in trie, else null.

## Sub\-classes

### TrieNode

#### Property Descriptions

### command

```gdscript
var command
```

@var  Command|null

#### Method Descriptions

### get\_children

```gdscript
func get_children()
```

@returns  Dictionary

### has\_child

```gdscript
func has_child(index)
```

@param    int  index
@returns  bool

### get\_child

```gdscript
func get_child(index)
```

@param    int  index
@returns  Dictionary

### initialize\_child\_at

```gdscript
func initialize_child_at(index)
```

@param    int       index
@returns  void