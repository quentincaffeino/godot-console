
extends Reference


const TypesList = [
  preload('Any.gd'),
  preload('Bool.gd'),
  preload('Int.gd'),
  preload('Float.gd'),
  preload('String.gd'),
  preload('Vector2.gd'),
]


# @param  int  type
static func build(type):  # BaseType
  return TypesList[type if type >= 0 and type < TypesList.size() else 0].new()
