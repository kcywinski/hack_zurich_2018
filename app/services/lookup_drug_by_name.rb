class LookupDrugByName 
  def initialize(name)
    @name = name
  end

  def process
    drugs = ApiRequest.new("drugs?name=#{@name}").process
    drugs.map { |x| x['title'] }.sort
  end  
end