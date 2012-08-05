{exec} = require 'child_process'
path = require 'path'

srcFile = path.join 'src', 'burst-queue.coffee'
outputFile = path.join 'lib', 'burst-queue.js'
testFile = path.join 'test', 'burst-queue-test.coffee'

coffeeCmd = path.join 'node_modules', '.bin', 'coffee'
mochaCmd = path.join 'node_modules', '.bin', 'mocha'

task 'build', ->
	buildCmd = "#{coffeeCmd} -j #{outputFile} -c #{srcFile}"
	console.log buildCmd
	exec buildCmd, (err, stdout, stderr) ->
		if err
			console.log(err) 
		else
			console.log "Compiled #{outputFile}"

task 'test', ->
	testCmd = "#{mochaCmd} #{testFile} --colors --compilers coffee:coffee-script"
	console.log testCmd
	exec testCmd, (err, stdout, stderr) ->
		console.log(stdout) if stdout
		console.log(stderr) if stderr
		console.log(err) if err
		


			


