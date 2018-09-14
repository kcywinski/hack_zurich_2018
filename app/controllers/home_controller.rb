class HomeController < ApplicationController 
    def index
        render json: Drug.all
    end
end
