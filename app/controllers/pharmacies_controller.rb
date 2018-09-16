class PharmaciesController < ApplicationController
  def index
    begin  
      pharmacies = ApiRequest.new("care-providers?category=5b33a5142c9dd24355626305&nearLimit=3&nearLat=#{pharmacies_params[:lat]}&nearLng=#{pharmacies_params[:long]}").process      
    rescue StandardError      
      []
    end    
    render json: JSON.parse(pharmacies)&.fetch('result')
  end

  private

  def pharmacies_params
    params.permit(:lat, :long)
  end
end