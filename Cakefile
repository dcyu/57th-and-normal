{print} = require 'util'
{spawn} = require 'child_process'

task 'build', 'Build js/ from src/', ->
  coffee = spawn 'coffee', ['-c', '-o', 'js', 'src']
  coffee.stderr.on 'data', (data) ->
    process.stderr.write data.toString()
  coffee.stdout.on 'data', (data) ->
    print data.toString()
  coffee.on 'exit', (code) ->
    callback?() if code is 0

task 'server', 'Watch src/ for changes', ->
  coffee = spawn 'coffee', ['-w', '-c', '-o', 'js', 'src']
  server = spawn 'http-server'
  
  coffee.stderr.on 'data', (data) ->
    process.stderr.write data.toString()
  coffee.stdout.on 'data', (data) ->
    print data.toString()
  
  server.stderr.on 'data', (data) ->
    process.stderr.write data.toString()
  server.stdout.on 'data', (data) ->
    print data.toString()