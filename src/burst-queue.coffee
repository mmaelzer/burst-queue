
class BurstQueue
	_queue = new Array()
	_counter = 0
	_maxItems = 0
	_availableCalls = 0

	constructor: (period, itemsPerPeriod) ->
		if itemsPerPeriod?
			_availableCalls = _maxItems = itemsPerPeriod
		else
			_availableCalls = _maxItems

		setInterval @process, period

	add: (functions) ->
		# check for typeof(Array)
		if Object.prototype.toString.apply(functions) == '[object Array]'
			ids = new Array()
			for fn in functions
				if _availableCalls > 0
					_availableCalls--
					fn()
				else 
					_queue.push { id : _counter, fn: fn }
				ids.push _counter++
			ids
		else
			if _availableCalls > 0
				_availableCalls--
				functions()
			else
				_queue.push { id : _counter, fn: functions }
			_counter++

	availableCalls: ->
		_availableCalls

	clear: ->
		_queue.length = 0	
		_availableCalls = _maxItems
		return

	counter: ->
		_counter

	enqueued: ->
		_queue.length

	process: ->
		if _queue.length < 1
			_availableCalls = _maxItems
			return

		for index in [0..(_queue.length - 1)]
			_queue[index].fn()
			if (index + 1) >= _maxItems
				break

		_queue.splice 0, index + 1

		if index < _maxItems
			_availableCalls = _maxItems - (index + 1)

	remove: (id) ->
		if _queue.length < 1
			return false

		success = false
		for index in [0..(_queue.length - 1)]
			if _queue[index].id == id
				success = true
				break
		if success
			_queue.splice index, 1
		return success


exports = module.exports

exports.createQueue = (period, functionsPerPeriod) ->
	new BurstQueue period, functionsPerPeriod


