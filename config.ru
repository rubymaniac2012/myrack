require 'hello'

#By default the cooling period is 10. we can customize it.
use Rack::Reloader, 0
use Rack::Auth::Basic do |username, password|
	password == 'secret'
	end

run Hello
