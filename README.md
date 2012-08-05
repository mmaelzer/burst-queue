burst-queue
===========
A simple queue that takes functions and executes those functions on a specified interval. Optionally a maximum number of functions to execute per interval can be specified when creating a burst-queue.

Methods
-------
### createQueue(period, [functionsPerPeriod]) ###
__Returns__: a burst-queue that will execute passed in functions every `period` (milliseconds). The optional `functionsPerPeriod` value denotes a maximum number of functions to be executed at each interval.


### add(fn) / add([fn1, fn2, ...]) ###
Adds functions to the queue. The `add` method takes both single functions or arrays of functions. 

__Returns__: the queue's internal id(s) of the passed in functions. The internal ids can be later used to `remove` items from the queue. If an array of functions is passed to `add`, an array of ids is returned in the same order as the functions that were passed in.

### availableCalls ###
Only valid when `functionsPerPeriod` is defined.

__Returns__: the number of calls available in the current period. In other words, any function passed in when `availableCalls()` returns a value greater than 0 will be executed immediately.

### clear ###
Clears the queue of all functions. Sets the `availableCalls` back to the original value of `functionsPerPeriod` that was specified on creation of the queue. If no value was given for `functionsPerPeriod`, `availableCalls` remains at 0.

__Returns__: nothing

### counter ###
__Returns__: the current value of the counter used for generating the queue's internal ids for functions. This value increments by one each time a function is added to the queue.

### enqueued ###
__Returns__: the current count of items in the queue.

### remove(id) ###
Takes an id returned from an `add` call and removes that function from the queue, if it is still in the queue.

__Returns__: a bool that designates whether the `remove` call successfully found and removed the function from the queue. If a function no longer exists in the queue when `remove` is called on its id, `remove` returns `false`.

