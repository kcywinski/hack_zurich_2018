class DrugsController < ApplicationController
  def index
    low_amount = Drug.low_amount
    render json: { all: Drug.all.count, low_amount_count: low_amount.count, low_amount: low_amount }
  end

  def full_list
    render json: Drug.all
  end

  def take_a_pill
    drug = Drug.find_by(swiss_id: params[:id])
    if drug.tabs_number > 0
      tabs_number = drug.tabs_number - 1            
      drug.update(tabs_number: tabs_number)
    end
    render json: { is_empty: tabs_number == 0 } 
  end
  
  def dosage    
    render json: LookupDrugByName.new(params[:swissid]).process.dosage
  end

  def create        
    drug = Drug.find_or_create_by(drug_params)
    drug.update(tabs_number: (drug&.tabs_number || 0) + drug_params[:tabs_number].to_i)  
    render json: drug.save ? :ok : :unprocessable_entity
  end

  private

  def drug_params
    params.permit(:swiss_id, :name, :pack_type, :tabs_number)
  end
end