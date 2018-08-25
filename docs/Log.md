
# Log


#### Memeber Properties

| Properties | Description |
|--|--|
| *TYPE* logLevel |  |


#### Member Functions

| Methods | Description |
|--|--|
| *void* setLogLevel(*int* inLogLevel = TYPE) | Messages lower than provided level won't be printed in console output |
| *void* log(*string* message, *int* type = TYPE) |  |
| *void* info(*string* message) |  |
| *void* warn(*string* message) |  |
| *void* error(*string* message) |  |


#### Enums

enum TYPE

- INFO
- WARNING
- ERROR
- NONE
