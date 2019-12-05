
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


# @param  string  pattern
# @param  string  subject
# @param  int     maxsplit
static func split(pattern, subject, maxsplit = 0):
  var r = RegEx.new()
  r.compile(pattern)

  var result = []

  var matches = r.search_all(subject)
  if matches.size() > 0:
    var beginning = 0

    for rematch in matches:
      result.append(subject.substr(beginning, rematch.get_start() - beginning))
      beginning = rematch.get_end()
    
    var lastMatch = matches.pop_back()
    result.append(subject.substr(lastMatch.get_end(), subject.length()))

  else:
    result.append(subject)

  return result
