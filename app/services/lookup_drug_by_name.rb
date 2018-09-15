class LookupDrugByName 
  attr_reader :dosage, :drug_name
  
  def initialize(id)
    @id = id
  end

  def process
    @drug_name = JSON.parse(ApiRequest.new("drugs/#{@id}/").process)['title']
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
    return present_drug('One pack:standard dose', 0) if drug_types.blank?
    # p drug_types[2]
    res = []
    drugs = HTMLEntities.new(:html4).decode(drug_types[2])
    drugs
      .gsub(/(<[a-z]+[[ ]{0,1}[\w=\\"]*]*>)|(<\/[a-z]*>)/, '')
      .split(/\([A-Z]\)/)
      .each_with_index { |x, i| res << present_drug(x, i) }    
    res
  end

  def present_drug(drug, index)    
    if drug.include?(':')
      drug_dosage = drug.split(':').second
    else
      drug_dosage = drug.gsub(@drug_name, '')
    end
    # drug_key, drug_dosage = drug.split(':').map { |x| x.split(';') }.flatten
    { type: @drug_name, dosage: drug_dosage, tabs_number: 6 + 2*index}
  end
end
