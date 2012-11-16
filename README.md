[![build status](https://secure.travis-ci.org/mmaelzer/burst-queue.png)](http://travis-ci.org/mmaelzer/burst-queue)
burst-queue
===========
A simple queue that takes functions and executes those functions on a specified interval. Optionally a maximum number of functions to execute per interval can be specified when creating a burst-queue.

### Objects ###

**Queue(period, [callsPerPeriod])**  
Returns a burst-queue that will execute passed-in functions every `period` (milliseconds). The optional `callsPerPeriod` value denotes a maximum number of functions to be executed at each interval.

    var Queue = require('burst-queue');
    // Call the oldest 20 functions every minute
    var queue = new Queue(60*1000, 20);

---------------

### Methods ###

**add(fn) / add([fn1, fn2, ...])**  
Adds functions to the queue. The `add` method takes either a single function or an array of functions. Returns the queue's internal id(s) of the passed in functions. The internal ids can be later used to `remove` items from the queue. If an array of functions is passed to `add`, an array of ids is returned in the same order as the functions that were passed in.

    var hello = function() { console.log("hello") };
    var comma = function() { console.log(",") };
    var space = function() { console.log(" ") };
    var is_it_me = function() { console.log("is it me") };
    var youre_looking_for = function() { console.log("you're looking for") };

    queue.add(hello);
    queue.add([ comma, space, is_it_me, space, youre_looking_for ]);

    //>hello, is it me you're looking for

  
**clear()**  
Clears the queue of all functions. 

    var queue = new Queue(60*1000, 2);
    queue.add([ hello, comma, comma, space );
    // the first 2 functions are called instantly since we must first
    // reach the calls per period limit before enqueueing functions
    console.log(queue.enqueued());
    //> 2
    queue.clear();
    console.log(queue.enqueued());
    //> 0

  
**enqueued()**  
Returns the current count of items in the queue.  

  
**remove(id)**  
Takes an id returned from an `add` call and removes that function from the queue, if it is still in the queue. Returns a bool that designates whether the `remove` call successfully found and removed the function from the queue. If a function no longer exists in the queue when `remove` is called on its id, `remove` returns `false`.

    var tryRemove = function(id) {
        if (queue.remove(id)) {
            console.log("success!");
        } else {
            console.log("fail!");
        }
    }

    var helloId = queue.add(hello);
    tryRemove(helloId);
    //> success!
    tryRemove(helloId);
    //> fail!


----------------

### Properties ###

**counter**  
Returns the current value of the counter used for generating the queue's internal ids for functions. This value increments by one each time a function is added to the queue.

**availableCalls**  
Only valid when `callsPerPeriod` is defined. Returns the number of calls available in the current period. Any function added to the queue in when `availableCalls` returns a value greater than 0 will be executed immediately.