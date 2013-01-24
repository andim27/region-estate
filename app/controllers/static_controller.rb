class StaticController < ApplicationController
   def index
     #render :text=>"Hello static"
     @dop_params_rows = DopParam.select("id,_parentId,name,fields_list").all
     @obj_rows=Obj.select("id,name").all.to_json.html_safe
     @total_rows      = @dop_params_rows.size
     @dop_params_rows = @dop_params_rows.to_json.html_safe

     render :template=>'admin/_dop_params_crud.html',:layout =>false
   end
end