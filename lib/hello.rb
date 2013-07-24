require 'erb'

class Hello	
	
	def self.call(env)
		new(env).response
	end
		
	def initialize(env)
		@request = Rack::Request.new(env)
	end

	def response
		case @request.path
			when "/" then
				Rack::Response.new(render("index.html.erb"))
			when "/personal" then
				Rack::Response.new do |response|
					response.set_cookie("name", @request.params["name"])
					response.redirect("/")
				end
			else 
				Rack::Response.new("Not Found",404)
			end
	end

	def render(template)
		path = File.expand_path("../views/#{template}",__FILE__)
		ERB.new(File.read(path)).result(binding)
	end
		
	def hello_name
		@request.cookies["name"] || "rack"
	end	
			
end		
