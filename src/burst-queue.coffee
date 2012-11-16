
class BurstQueue
	_queue = new Array()
	_maxItems = 0

	constructor: (period, itemsPerPeriod) ->
		@counter = 0
		@availableCalls = _maxItems = if itemsPerPeriod? then itemsPerPeriod else _maxItems
		setInterval @process, period

	add: (functions) ->
		# check for typeof(Array)
		if Object.prototype.toString.apply(functions) == '[object Array]'
			ids = new Array()
			for fn in functions
				if @availableCalls > 0
					@availableCalls--
					fn()
				else 
					_queue.push { id : @counter, fn: fn }
				ids.push @counter++
			ids
		else
			if @availableCalls > 0
				@availableCalls--
				functions()
			else
				_queue.push { id : @counter, fn: functions }
			@counter++

	clear: ->
		_queue.length = 0	
		return

	enqueued: ->
		_queue.length

	process: ->
		if _queue.length < 1
			@availableCalls = _maxItems
			return

		for index in [0..(_queue.length - 1)]
			_queue[index].fn()
			if (index + 1) >= _maxItems then break

		_queue.splice 0, index + 1

		if index < _maxItems
			@availableCalls = _maxItems - (index + 1)

	remove: (id) ->
		if _queue.length < 1
			return false

		success = false
		for index in [0..(_queue.length - 1)]
			if _queue[index].id == id
				success = true
				break
		if success then	_queue.splice(index, 1)
		return success


module.exports = BurstQueue