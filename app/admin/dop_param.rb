ActiveAdmin.register DopParam do
 menu :parent => "Objects",:label => "Dop params", :priority => 2
 config.sort_order = "id_asc"

  index do
    #render :template=>'admin/_dop_params_crud.html'##,:layout =>"active_admin"
    iframe :src=>'static/dop_params',:width=>"800", :height=>"480"
  end
  #controller do
  #  def show
  #    render :template=>'admin/_dop_params_crud.html',  :layout =>"active_admin"
  #  end
  #end
end