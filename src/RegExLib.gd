
extends Reference


# @const  Dictionary
const _patterns = {
  '1': '^(1|0|true|false)$',  # bool
  '2': '^[+-]?\\d+$',  # int
  '3': '^[+-]?([0-9]*[\\.]?[0-9]+|[0-9]+[\\.]?[0-9]*)([eE][+-]?[0-9]+)?$',  # float

  'console.eraseTrash': '\\[[\\/]?[a-z0-9\\=\\#\\ \\_\\-\\,\\.\\;]+\\]',
}

# @var  RegEx[]
var _compiled = {}


# @param  int  type
func getPatternFor(type):  # RegEx|int
  type = str(type)

  if !_compiled.has(type):
    if !_patterns.has(type):
      return FAILED

    var r = RegEx.new()
    r.compile(_patterns[type])

    if r and r is RegEx:
      _compiled[type] = r
    else:
      return FAILED

  return _compiled[type]
