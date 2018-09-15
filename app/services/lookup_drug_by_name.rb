class LookupDrugByName 
  def initialize(id)
    @id = id
  end

  def process
    @drugs = ApiRequest.new("drugs/#{@id}/info/patient").process      
    p find_dosage
    find_drug_types
  end  

  private

  def find_dosage
    # @drugs.match(/<span>Dosierungsempfehlung: (.*)
  end

  def find_drug_types
    @drugs.match(/(<span>Packungen<\/span>)(.*)(<span>Zulassungsinhaberin<\/span>)/)[2]
      .gsub(/(<[a-z]+[[ ]{0,1}[\w=\\"]*]*>)|(<\/[a-z]*>)/, '')
      .split(/\([A-Z]\)/)
      .map { |x| present_drug(x) }    
  end

  def present_drug(drug)
    drug_key, drug_dosage = drug.split(':')
    { type: drug_key, dosage: drug_dosage}
  end
end
