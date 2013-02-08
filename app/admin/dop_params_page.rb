 ActiveAdmin.register_page "dop_params_page" do
    menu :label => "Dop params page", :parent => "Dashboard"

   content do
     iframe :src=>'static/dop_params',:width=>"800", :height=>"600"
   #####render :template=>'admin/_dop_params_crud.html'##,:layout =>"active_admin"
   end

   #index :as => :grid, :columns => 1 do
   #  render :template=>'admin/_dop_params_crud.html'##,:layout =>"active_admin"
   #end
 end