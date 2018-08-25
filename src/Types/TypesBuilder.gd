
extends Reference


const TypesList = [
  preload('Any.gd'),
  preload('Bool.gd'),
  preload('Int.gd'),
  preload('Float.gd'),
  preload('String.gd'),
  preload('Vector2.gd'),
  null,  # Rect2
  preload('Vector3.gd'),
]


# @param  int  type
static func build(type):  # BaseType
  return TypesList[type if type >= 0 and type < TypesList.size() and TypesList[type] != null else 0].new()
