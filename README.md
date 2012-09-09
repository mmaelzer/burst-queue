burst-queue
===========
A simple queue that takes functions and executes those functions on a specified interval. Optionally a maximum number of functions to execute per interval can be specified when creating a burst-queue.

### Constructor Method ###

* `Queue.createQueue(period, [callsPerPeriod])` : Returns a burst-queue that will execute passed-in functions every `period` (milliseconds). The optional `callsPerPeriod` value denotes a maximum number of functions to be executed at each interval.

### Instance Methods ###

* `qeue.add(fn) / add([fn1, fn2, ...])` : Adds functions to the queue. The `add` method takes either a single callback or an array of functions. Returns the queue's internal id(s) of the passed in functions. The internal ids can be later used to `remove` items from the queue. If an array of functions is passed to `add`, an array of ids is returned in the same order as the functions that were passed in.
* `queue.availableCalls()` : Only valid when `callsPerPeriod` is defined. Returns the number of calls available in the current period. In other words, any function passed in when `availableCalls()` returns a value greater than 0 will be executed immediately.
* `queue.clear()` : Clears the queue of all callbacks. Sets the `availableCalls` back to the original value of `callsPerPeriod` that was specified on creation of the queue. If no value was given for `callsPerPeriod`, `availableCalls` remains at 0.
* `queue.remove(id)` : Takes an id returned from an `add` call and removes that function from the queue, if it is still in the queue. Returns a bool that designates whether the `remove` call successfully found and removed the function from the queue. If a function no longer exists in the queue when `remove` is called on its id, `remove` returns `false`.

### Instance Properties ###

* `queue.counter` : Returns the current value of the counter used for generating the queue's internal ids for callbacks. This value increments by one each time a function is added to the queue.
* `queue.enqueued` : Returns the current count of items in the queue.