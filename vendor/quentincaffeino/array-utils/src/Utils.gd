
extends Reference


# @param  Variant  value
static func toArray(value):  # Variant[]
  if isArray(value):
    return value

  elif typeof(value) != TYPE_NIL:
    return [value]

  return []


# @param  Variant  value
static func isArray(value):  # bool
  if typeof(value) >= TYPE_ARRAY and typeof(value) <= TYPE_COLOR_ARRAY:
    return true

  return false


# @param  Variant  value
static func toDict(value):  # Dictionary
  if typeof(value) == TYPE_DICTIONARY:
    return value

  var d = {}

  if typeof(value) != TYPE_NIL:
    if isArray(value):
      for i in value.size():
        d[i] = value[i]
    else:
      d[0] = value

  return d


# @param  Array  array
# @param  Array  destArr
static func flatten(array, destArr = []):
  for i in array.size():
    if typeof(array[i]) == TYPE_ARRAY:
      flatten(array[i], destArr)
    else:
      destArr.append(array[i])

  return destArr
