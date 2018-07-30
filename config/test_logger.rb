require 'logstash-logger'

logger = LogStashLogger.new(type: :tcp, port: 5000 )
logger.info 'test'
logger.error '{"message": "error"}'
logger.debug message: 'test', foo: 'bar'
logger.warn LogStash::Event.new(message: 'test', foo: 'bar')
logger.tagged('foo') { logger.fatal('bar') }
