class StaticController < ApplicationController
   def index
     #render :text=>"Hello static"
     render :template=>'admin/_dop_params_crud.html',:layout =>false
   end
end