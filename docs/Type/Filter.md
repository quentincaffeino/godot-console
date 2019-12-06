
# **Filter** extends BaseType


[Code](https://github.com/QuentinCaffeino/godot-console/blob/dev/src/Type/Filter.gd)


#### Memeber Properties

| Properties | Description |
|--|--|
| *enum* MODE( ALLOW, DENY ) | Filter mode. |


#### Member Functions

| Methods | Description |
|--|--|
| *Filter* _init(*Variant[]* fliterList, *MODE* mode = ALLOW) |  |
| *int* check(*Variant* value) | Checks value and returns OK or FAILED status. |
