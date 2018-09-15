class LookupDrugByName 
  attr_reader :dosage, :drug_name
  
  def initialize(id)
    @id = id
  end

  def process
    # @drug_name = JSON.parse(ApiRequest.new("drugs/#{@id}/").process)['title']
    begin
      @drugs = ApiRequest.new("drugs/#{@id}/info/patient").process      
    rescue StandardError      
      @drugs = '<span>Packungen</span>One pack:standard dose<span>Zulassungsinhaberin</span>'
    end
    @dosage = find_drug_types
    self
  end  

  private

  def find_dosage
    # @drugs.match(/<span>Dosierungsempfehlung: (.*)
  end

  def find_drug_types
    drug_types = @drugs.match(/(<span>Packungen<\/span>)(.*)(<span>Zulassungsinhaberin<\/span>)/)
    p drug_types
    return present_drug('One pack:standard dose') if drug_types.blank?
    res = []
    drug_types[2]
      .gsub(/(<[a-z]+[[ ]{0,1}[\w=\\"]*]*>)|(<\/[a-z]*>)/, '')
      .split(/\([A-Z]\)/)
      .each_with_index { |x, i| res << present_drug(x, i) }    
    res
  end

  def present_drug(drug, index)
    drug_key, drug_dosage = drug.split(':').map { |x| x.split(';') }.flatten
    { type: drug_key, dosage: drug_dosage, tabs_number: 6 + 2*index}
  end
end
