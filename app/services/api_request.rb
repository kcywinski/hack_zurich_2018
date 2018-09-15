class ApiRequest 
  def initialize(api_url)
    @token = 'subdued sail'
    @api_url = api_url
  end

  def process
    request = Typhoeus::Request.new(
    "#{base_url}#{@api_url}",
     headers: { Authorization: @token }
    )    
    request.on_complete do |response|
      if response.success?
        return response.body
      elsif response.timed_out?        
        p "got a time out"
      elsif response.code == 0        
        p response.return_message
      else        
        p "HTTP request failed: " + response.code.to_s
      end
    end
    request.run
  end

  def base_url
    'https://health.axa.ch/hack/api/'
  end
end