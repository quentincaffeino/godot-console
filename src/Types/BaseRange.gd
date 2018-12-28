
extends 'BaseType.gd'


# @var  int|float
var _minValue

# @var  int|float
var _maxValue

# @var  int|float
var _step


# @param  int|float  minValue
# @param  int|float  maxValue
# @param  int|float  step
func _init(minValue, maxValue, step):
  self._minValue = minValue
  self._maxValue = maxValue
  self._step = step


func getMinValue():  # int|float
  return self._minValue


# @param  int|float  minValue
func setMinValue(minValue):  # BaseRange
  self._minValue = minValue
  return self


func getMaxValue():  # int|float
  return self._maxValue


# @param  int|float  maxValue
func setMaxValue(maxValue):  # BaseRange
  self._maxValue = maxValue
  return self


func getStep():  # int|float
  return self._step


# @param  int|float  step
func setStep(step):  # BaseRange
  self._step = step
  return self

# Assignment check for datatype and range.
# Returns one of the statuses:
# OK, FAILED and CANCELED
# @param  Varian  originalValue
func check(originalValue):  # int
  var check = .check(originalValue)
  if check == OK:
    # Is the value within the range?
    var intValue = int(originalValue)
    if intValue < _minValue or intValue > _maxValue: # TODO: Is maxValue inclusive?
      check = FAILED
  return check

func toString():  # string
  var name = self._name + '(' + str(self._minValue) + '-' + str(self._maxValue)

  if self._step != 1:
    name += ', step: ' + str(self._step)

  return name + ')'
