module Checks
  module Constants
    DEFAULT_OPTS = {
      host:       '127.0.0.1',
      check_type: 'ssh',
      timeout:    1,
      sleep:      1,
      tries:      3
    }.freeze
  end
end
