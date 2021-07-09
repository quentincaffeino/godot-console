
extends "res://addons/gut/test.gd"

const Trie = preload("res://addons/quentincaffeino/console/src/Misc/Trie.gd")


func test_insert():
    var trie = Trie.new()
    trie.insert("key", "hello world")
    assert_true(trie.has("key"))


func test_has():
    var trie = Trie.new()
    trie.insert("key", "hello world")
    assert_false(trie.has("yek"))


func test_get():
    var trie = Trie.new()
    trie.insert("key", "hello world")
    assert_eq("hello world", trie.get("key"))
