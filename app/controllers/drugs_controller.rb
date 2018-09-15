class DrugsController < ApplicationController
  def index
    render json: { all: Drug.all.count, low_amount: Drug.low_amount.count }
  end
  
  def dosage
    render json: LookupDrugByName.new(params[:swissid]).process
  end

  def create    
    drug = Drug.new(drug_params)  
    render json: drug.save ? :ok : :unprocessable_entity
  end

  private

  def drug_params
    params.require(:drug).permit(:name, :amount_left)
  end
end