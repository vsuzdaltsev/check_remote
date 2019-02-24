require_relative File.expand_path('constants', __dir__)
require_relative File.expand_path('service_manager', __dir__)
require          'chef/application'

# Create check object
# @param [opts] [Hash] - options to pass to Service class instance
class CheckRemote
  def initialize(opts = {}, defaults: true)
    @opts  = load_defaults(opts, defaults)
    @check = Class.const_get(check_type + 'ServiceManager').new(service).freeze
  rescue StandardError => err
    fatal(err)
  end

  # Run service check with generated ServiceManager instance
  # @return [Boolean] - the result of service check
  def wait_until_up
    @check.wait_until_up
  end

  private

  def load_defaults(opts, defaults)
    return Checks::Constants::DEFAULT_OPTS.merge(opts) if defaults

    opts
  end

  def service
    ServiceBuilder.build do |builder|
      @opts.each_key do |param|
        builder.public_send("#{param}=", @opts[param])
      end
    end
  end

  def fatal(err)
    Chef::Application.fatal!("Wrong options: #{err}", 1)
  end

  def check_type
    @opts[:check_type].capitalize
  end
end
