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
      else
        raise StandardError      
      end
    end
    request.run
  end

  def base_url
    'https://health.axa.ch/hack/api/'
  end
end