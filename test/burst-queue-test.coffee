## burst-queue test
should = require 'should'

BurstQueue = require '../src/burst-queue'

describe 'burst-queue', ->

	queue = BurstQueue.createQueue 500, 1

	beforeEach (done) ->
		queue.clear()
		done()

	describe '#add()', ->
		it 'should return an incrementing id', (done) ->
			counter = queue.counter()
			test1 = ->
				foo = "bar"
			(queue.add test1).should.equal counter
			test2 = ->
				bar = "foo"
			(queue.add test2).should.equal(counter + 1)
			done()
		it 'should accept arrays of functions and return arrays of ids', (done) ->
			counter = queue.counter()
			test1 = ->
				foo = "bar"
			test2 = ->
				bar = "foo"
			array = queue.add [test1, test2]
			array[0].should.equal counter
			array[1].should.equal(counter + 1)
			done()

	describe '#remove()', ->
		it 'should remove a function when remove() is called with the function id', (done) ->
			test1 = ->
				foo = "bar"
			test2 = ->
				bar = "foo"
			id1 = queue.add test1
			id2 = queue.add test2
			(queue.remove(id2)).should.be.true
			done()

	describe '#clear()', ->
		it 'should clear the queue of all functions', (done) ->
			for i in [1..1000]
				queue.add(() -> foo = "bar")
			(queue.enqueued()).should.be.above 0
			queue.clear()
			(queue.enqueued()).should.equal 0
			done()

	it 'should process functions in the order they are passed in', (done) ->
		testVal1 = false
		testVal2 = false

		test1 = ->
			testVal1 = true
		test2 = ->
			testVal2 = true
		test3 = ->			
			if testVal1 and testVal2
				done()
			else
				throw new Error()

		queue.add [test1, test2, test3]

	it 'should execute functions in predefined chunks at a given interval', (done) ->
		start = new Date()
		firstFired = new Date()
		secondFired = new Date()
		test1 = ->
			if new Date() - start < 0
				throw new Error()
		test2 = ->
			if new Date() - start < 400
				throw new Error()
		test3 = ->			
			if new Date() - start < 800
				throw new Error()
			else
				done()

		queue.add [test1, test2, test3]

	it 'should execute functions immediately if queue is empty and max number of items per period is not reached', (done) ->
		if queue.availableCalls() > 0
			start = new Date()
			test = ->
				if new Date() - start > 400
					throw new Error()
				else
					done()
			queue.add test
		else
			throw new Error()









