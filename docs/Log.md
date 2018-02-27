
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
| *void* info(*string* message, *string* debugInfo = '') |  |
| *void* warn(*string* message, *string* debugInfo = '') |  |
| *void* error(*string* message, *string* debugInfo = '') |  |
| *void* debug(*string* message, *string* debugInfo = '') | Printed only if debug mode is enabled |


#### Enums

enum TYPE

- INFO
- WARNING
- ERROR
- NONE
