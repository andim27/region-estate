ActiveAdmin.register Zayavka do
  config.sort_order = "id_asc"
  ##config.register_stylesheet 'simpletabs.css'
  menu :parent => "Zayavki", :label => "Zayavki all"
  scope :all, :default => true
  scope :today do |z|
    z.where("DATE(created_at) = DATE(?)",Time.now)
  end
  scope :For_Three_day  do |z|
    z.where("DATE(created_at) >= DATE(?)",Time.now-3.day)
  end
  scope :For_Week  do |z|
    z.where("DATE(created_at) >= DATE(?)",Time.now-7.day)
  end
  scope :For_Month  do |z|
    z.where("DATE(created_at) >= DATE(?)",Time.now-30.day)
  end
  scope :More_when_One_month  do |z|
    z.where("DATE(created_at) <= DATE(?)",Time.now-30.day)
  end
  scope :More_when_Three_month  do |z|
    z.where("DATE(created_at) <= DATE(?)",Time.now-90.day)
  end
  filter :published, :as => :select
  filter :id
  filter :contact
  filter :tel_1
  filter :tel_2
  filter :dop
  filter :info_type
  filter :info_source, :label=>"InfoSource",:collection=>proc {InfoSource.all}
  ##filter :obj_id, :as => :select, :collection => proc { Obj.order('name ASC').map(&:name) }
  ##filter :info_source, :label=>"Agency",:collection=>proc {InfoSource.from_agency}
  ##filter :info_source, :label=>"Peaple",:collection=>proc {InfoSource.from_people}
  #filter :obj_id,:collection => proc { Obj.all },:as=>:select
  sidebar :filters_Have, :if=>proc{request.url.match(/zayavkas$|filterhave/)} do
    render :template=>'admin/_zayavka_have_filter.html'
  end

  ##------------------------------------------CONTROLLER-------------------


  controller do

    def edit(options={}, &block)
      @zayavka_id=params[:id]
      render :template=>'admin/_zayavka_crud.html' ,:layout =>"active_admin"
      #super do |format|
      #  block.call(format) if block
      #  #format.html { render active_admin_template('edit') }
      #  @cur_id=params[:id]
      #  #format.html {  render :text=>"Edit member #{params[:id]}"}
      #  format.html {render :template=>'admin/_zayavka_crud.html' ,:layout =>"active_admin"}
      #end
    end
    def new
        @action="new"
        ##ActiveRecord::Base.include_root_in_json = false
        @havefields    = HaveField.select("id,name,field_name,field_ui_type").all.to_json
        @zayavka_fields= Zayavka.column_names;
        @info_sources  = InfoSource.select("id,name").all.to_json
        @info_types    = InfoType.select("id,name").all.to_json
        @objs          = Obj.select("id,name").all.to_json
        @states        = State.select("id,name").all.to_json
        @rayons        = Rayon.select("id,name").where("parent=2775").to_json
        render :template=>'admin/_zayavka_crud.html' ,:layout =>"active_admin"
    end
    def show
      @action="show"
      @zayavka_id=params[:id]
      ##ActiveRecord::Base.include_root_in_json = false
      @zayavka_fields=Zayavka.column_names;
      render :template=>'admin/_zayavka_crud.html' ,:layout =>"active_admin"
    end

    def scoped_collection
     if params[:filterhave].present?
       cond_str=" 1=1 "
       #------------operation------------------------
       if params[:obmen_want].present?
         obmen_want_str=" AND h.obmen_want=#{params[:obmen_want]}"
       else
         obmen_want_str=""
       end
       if params[:sell_want].present?
         sell_want_str=" AND h.sell_want=#{params[:sell_want]}"
       else
         sell_want_str=""
       end
       if params[:rent_want].present?
         rent_want_str=" AND h.rent_want=#{params[:rent_want]}"
       else
         rent_want_str=""
       end
       #----------- attributes-----------------------
       if params[:obj_id].present?
         obj_id_str=" AND h.obj_id=#{params[:obj_id]}"
       else
         obj_id_str=""
       end
       if params[:rayon_id].present?
         rayon_id_str=" AND h.rayon_id=#{params[:rayon_id]}"
        else
          rayon_id_str=""
        end
       if params[:street_id].present?
         street_id_str=" AND h.street_id=#{params[:street_id]}"
       else
         street_id_str=""
       end
       if params[:room].present?
         room_str=" AND h.room=#{params[:room]}"
       else
         room_str=""
       end
       if params[:price_from].present?
         price_from_str=" AND h.price_want >=#{params[:price_from]}"
       else
         price_from_str=""
       end
       if params[:price_to].present?
         price_to_str=" AND h.price_want <=#{params[:price_to]}"
       else
         price_to_str=""
       end
       if params[:dop].present?
         dop_str=" AND h.dop LIKE ('%#{params[:dop]}%')"
       else
         dop_str=""
       end
       cond_str=cond_str+obmen_want_str+sell_want_str+rent_want_str+obj_id_str+rayon_id_str+street_id_str+room_str+price_from_str+price_to_str+dop_str
       Zayavka.select("zayavkas.*").from("zayavkas").where(" zayavkas.id IN (SELECT h.zayavka_id FROM haves as h WHERE #{cond_str})").order("id asc")
     else
      Zayavka.order("id asc").select("*")
     end
   end

  end

  #member_action :editmy, :method => :put do
  #
  #  redirect_to :action => :editmy
  #  render :text=>"Edit member #{params[:id]}"
  #
  #end

  #-------------------------------------------TABLE----------------------
  index :as=>:table do
    column :id
    column :created_at do |rec|
      span rec.created_at.to_date
      if rec.have[0].obmen_want !=0
        br
        span "(obmen)"
      end
    end

    column :have do |rec|
      out_str=""
      obj_str,rayon_str,street_str,floor_str,s_str,tel_str,dop_str="?"
      if !rec.have.empty?
        rec.have.each do |h|
          room_str = h.room ==0?"":h.room
          obj_str=h.obj.name if h.obj != nil
          rayon_str=h.rayon.name+", " if !h.rayon.name.empty?
          street_str=h.street.name_rus   if h.street != nil
          floor_str=I18n.t('etag')+":"+h.floor.to_s+"/"+h.floor_house.to_s+", "
          s_str='S='+h.s_all.to_s+"/"+h.s_live.to_s+"/"+h.s_kux.to_s+", "
          #dop_str=h.dop if h.dop != nil
          if h.obj.id==1 # doplata
            span obj_str+":"+((h.price_want !=0)?(h.price_want.to_s) :'?')
          else
            span room_str
            span obj_str
            span rayon_str
            span street_str
            br
            span floor_str
            span s_str
            if h.sell_want != 0
              br span "(sel_want:"+h.price_want.to_s+" )"
            end
            br
            a "more...", :href=>"javascript:alert('more...#{h.id}');"
            hr if h.variant_cnt >1
          end
          br
        end
      end
      #out_str
    end
    column :want do |rec|
      if rec.have[0].sell_want !=0
        span "sell_want:"+rec.have[0].price_want.to_s
        br
      end
      out_str=""
      if !rec.want.empty?
        rec.want.each do |w|
          if w.obj.id==1 # doplata
            span (w.obj.name+":"+w.price_want.to_s)  if w.price_want !=0
          else #objects
            span w.room       if w.room !=0
            span w.obj.name   if w.obj != nil
            span w.rayon.name if w.rayon != nil
          end
          br
        end
      end
    end
    default_actions
  end
end