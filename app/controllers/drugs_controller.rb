class DrugsController < ApplicationController
  def index
    low_amount = Drug.low_amount
    render json: { all: Drug.all.count, low_amount_count: low_amount.count, low_amount: low_amount }
  end

  def full_list
    render json: Drug.all
  end

  def take_a_pill
    drug = Drug.find_by(params[:swiss_id])
    tabs_number = drug.tabs_number - 1    
    if tabs_number == 0
      packs_amount = drug.packs_amount - 1
      tabs_number = 6
    end
    drug.update(tabs_number: tabs_number, packs_amount: packs_amount)
    render json: { is_empty: drug.reload.packs_amount == 0 } 
  end
  
  def dosage    
    render json: LookupDrugByName.new(params[:swissid]).process.dosage
  end

  def create    
    drug_name = LookupDrugByName.new(drug_params[:swiss_id]).process.drug_name
    drug = Drug.find_or_create_by(drug_params.merge(name: drug_name))
    drug.update(packs_amount: (drug&.packs_amount || 0) + 1)  
    render json: drug.save ? :ok : :unprocessable_entity
  end

  private

  def drug_params
    params.permit(:swiss_id, :name, :pack_type, :tabs_number)
  end
end