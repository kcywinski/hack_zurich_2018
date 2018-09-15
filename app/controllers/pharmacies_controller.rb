class PharmaciesController < ApplicationController
  def index
    json = 
      [
        {
          "_id": "186516",
          "name": "Hitziger",
          "firstName": "Maria",
          "street": "Hardstrasse",
          "houseNr": "235",
          "zipCode": "8005",
          "city": "Zürich",
          "country": "CH",
          "geocode": {
              "location": {
                  "lat": 47.38776499999999,
                  "lng": 8.518873
              },
              "place_id": "ChIJwwf9Yj8KkEcRl_57kWWIn3s"
          },
          "distance": 346.9456278806794,
          "typeData": {
              "_id": "5b33a6142c9dd24355626349",
              "de": "Apotheken",
              "en": "pharmacies",
              "category": "5b33a5142c9dd24355626305",
              "syrKey": "2000",
              "syrGroup": "20"
          },
          "categoryData": {
              "_id": "5b33a5142c9dd24355626305",
              "syrKey": "20",
              "de": "Apotheken",
              "en": "pharmacies"
          },
          "type": "5b33a6142c9dd24355626349",
          "title": "leer"
      },
      {
          "_id": "140374",
          "name": "ApoDoc Hardbrücke",
          "street": "Hardstrasse",
          "houseNr": "235",
          "zipCode": "8005",
          "city": "Zürich",
          "country": "CH",
          "phone": "+41 44 922 44 55",
          "fax": "+41 44 922 44 56",
          "email": "apotheke@apodoc.ch",
          "web": "www.apodoc.ch",
          "geocode": {
              "location": {
                  "lat": 47.38776499999999,
                  "lng": 8.518873
              },
              "place_id": "ChIJwwf9Yj8KkEcRl_57kWWIn3s"
          },
          "distance": 346.9456278806794,
          "typeData": {
              "_id": "5b33a6142c9dd24355626349",
              "de": "Apotheken",
              "en": "pharmacies",
              "category": "5b33a5142c9dd24355626305",
              "syrKey": "2000",
              "syrGroup": "20"
          },
          "categoryData": {
              "_id": "5b33a5142c9dd24355626305",
              "syrKey": "20",
              "de": "Apotheken",
              "en": "pharmacies"
          },
          "type": "5b33a6142c9dd24355626349"
      },
      {
          "_id": "237115",
          "name": "Rauseo",
          "firstName": "Valeria",
          "street": "Hönggerstrasse",
          "houseNr": "40",
          "zipCode": "8037",
          "city": "Zürich",
          "country": "CH",
          "geocode": {
              "location": {
                  "lat": 47.39240969999999,
                  "lng": 8.5247361
              },
              "place_id": "ChIJWbEaHWoKkEcRxnA6hZLQbEI"
          },
          "distance": 712.7875158947312,
          "typeData": {
              "_id": "5b33a6142c9dd24355626349",
              "de": "Apotheken",
              "en": "pharmacies",
              "category": "5b33a5142c9dd24355626305",
              "syrKey": "2000",
              "syrGroup": "20"
          },
          "categoryData": {
              "_id": "5b33a5142c9dd24355626305",
              "syrKey": "20",
              "de": "Apotheken",
              "en": "pharmacies"
          },
          "type": "5b33a6142c9dd24355626349",
          "title": "leer"
      }
    ]
    render json: json
  end

  def index2
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