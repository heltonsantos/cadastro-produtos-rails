require 'net/http'

module RequestHelper

	def self.request_post_form(uri, params)
		request = Net::HTTP.post_form(URI.parse(uri), params)
    puts request.body
	end

end
