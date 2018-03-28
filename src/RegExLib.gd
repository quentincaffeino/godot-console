
extends Reference


const _patterns = {
  '1': '^(1|0|true|false)$',  # bool
  '2': '^[+-]?\\d+$',  # int
  '3': '^[+-]?([0-9]*[\\.]?[0-9]+|[0-9]+[\\.]?[0-9]*)([eE][+-]?[0-9]+)?$',  # float

  'console.eraseTrash': '\\[[\\/]?[a-z\\=\\#0-9\\ \\_\\-\\,\\.]+\\]',
}

# @var  Array<RegEx>
var _compiled = {}


# @param  int  type
func get(type):  # RegEx|int
  var strType = str(type)

  if !_compiled.has(strType):
    if !_patterns.has(strType):
      return FAILED

    var r = RegEx.new()
    r.compile(_patterns[strType])

    if r and r is RegEx:
      _compiled[strType] = r
    else:
      return FAILED

  return _compiled[strType]
