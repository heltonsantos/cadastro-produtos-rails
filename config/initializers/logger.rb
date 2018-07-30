require 'logstash-logger'

$logger = LogStashLogger.new(type: :tcp, port: 5000 )
