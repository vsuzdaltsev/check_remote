# Construct Service object
require 'abstracts'

# Service class
class Service < Abstract::Object
  @attrs = %i[
    host
    port
    check_type
    timeout
    sleep
    tries
  ]
end

# Builder class
class ServiceBuilder < Abstract::Builder
  @build_class = 'Service'
end

