# check_remote
git clone https://github.com/vsuzdaltsev/check_remote.git   
cd check_remote   
gem install bundler   
bundle install   
irb   
>irb(main):001:0> load 'lib/check_remote.rb'   
[2018-10-25T16:42:06+03:00] WARN: Please install an English UTF-8 locale for Chef to use, falling back to C locale and disabling UTF-8 support.   
=> true   
irb(main):002:0> check = CheckRemote.new   
=> #<CheckRemote:0x00000001fb5b20 @opts={:host=>"127.0.0.1", :check_type=>"ssh", :timeout=>1, :sleep=>1, :tries=>3}, @check=#<SshServiceManager:0x00000001fb4b80 @service=#<Service:0x00000001fb59e0 @host="127.0.0.1", @check_type="ssh", @timeout=1, @sleep=1, @tries=3, @port=22>, @remote="127.0.0.1:22/tcp">>   
irb(main):003:0> check.wait_until_up   
[2018-10-25T16:42:18+03:00] WARN: Trying to check if ssh service up   
[2018-10-25T16:42:18+03:00] WARN: * Waiting for connection to 127.0.0.1:22/tcp..   
[2018-10-25T16:42:19+03:00] WARN: * Waiting for connection to 127.0.0.1:22/tcp..   
[2018-10-25T16:42:20+03:00] WARN: * Waiting for connection to 127.0.0.1:22/tcp..   
[2018-10-25T16:42:21+03:00] ERROR: * Failed to connect! 127.0.0.1:22/tcp is unreachable after 3 tries.   
=> false   

