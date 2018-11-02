require_relative File.expand_path('service', __dir__)

# Check if service available
class ServiceManager
  require 'socket'
  require 'timeout'

  # @param service [Service] - Service instance
  # @return  - ServiceManager instance
  def initialize(service)
    @service = service
  end

  # Aggregate all the checks
  def wait_until_up
    Chef::Log.warn("Trying to check if #{@service.check_type} service up")
  end
end

# TCP checker class
class TCPServiceManager < ServiceManager
  def wait_until_up
    super
    wait_until_socket_up
  end

  private

  # Try to check service socket N times
  # @return [Boolean] - the result of service check
  def wait_until_socket_up
    @service.tries.times do
      return true if port_reachable?
      wait_connection
    end
    connection_failed
  end

  def reachable
    Chef::Log.warn("* Successfully connected! #{@remote} is reachable")
    true
  end

  def wait_connection
    Chef::Log.warn("* Waiting for connection to #{@remote}..")
    sleep @service.sleep
    false
  end

  def connection_failed
    Chef::Log.error("* Failed to connect! #{@remote} is unreachable after #{@service.tries} tries.")
    false
  end

  # Check if remote port is open
  # @return [Boolean] - the result of remote port check
  def port_reachable?
    Timeout.timeout(@service.timeout) do
      TCPSocket.new(@service.host, @service.port).close
      reachable
      return true
    end
    false
  rescue StandardError
    false
  end
end

# Check if ssh service available
class SshServiceManager < TCPServiceManager
  def initialize(service)
    super
    @service.port = 22
    @remote = "#{@service.host}:#{@service.port}/tcp"
  end
end

# Check if mysqld service available
class MysqlServiceManager < TCPServiceManager
  def initialize(service)
    super
    @service.port = 3306
    @remote = "#{@service.host}:#{@service.port}/tcp"
  end

  def wait_until_up
    super
    additional_mysql_check
  end

  def additional_mysql_check
    Chef::Log.warn("Performing additional #{@service.check_type} check...")
    false
  end
end
