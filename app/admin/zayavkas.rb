ActiveAdmin.register Zayavka do
  config.batch_actions = true
  #config.sort_order = "id_asc"
  config.sort_order = "id_desc"
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
  filter :status
  ##filter :obj_id, :as => :select, :collection => proc { Obj.order('name ASC').map(&:name) }
  ##filter :info_source, :label=>"Agency",:collection=>proc {InfoSource.from_agency}
  ##filter :info_source, :label=>"Peaple",:collection=>proc {InfoSource.from_people}
  #filter :obj_id,:collection => proc { Obj.all },:as=>:select
  sidebar :filters_Have, :if=>proc{request.url.match(/zayavkas$|filterhave/)} do
    render :template=>'admin/_zayavka_have_filter.html'
  end

  ##------------------------------------------CONTROLLER-------------------


  controller do
   ## befor_filter: "getListsData"
    def getListData(act)
      @action=act
      ##ActiveRecord::Base.include_root_in_json = false
      @havefields    = HaveField.select("id,name,field_name,field_ui_type").all.to_json
      @zayavka_fields= Zayavka.column_names;
      @info_sources  = InfoSource.select("id,name").all.to_json
      @info_types    = InfoType.select("id,name").all.to_json
      @objs          = Obj.select("id,name").all.to_json
      @states        = State.select("id,name").all.to_json
      @statuses      = Status.select("id,name").all.to_json
      @rayons        = Rayon.select("id,name").where("parent=2775").to_json
      @dop_params    = DopParam.all.to_json
      #@rents         = HaveField.select("id,name,field_list").where("field_name='rent_want'")
      @dogovor='[{id:1,name:"no",{id:1,name:"excluzive"}}]'
      @rents = '[{id:1,name:"day"},{id:2,name:"week"},{id:3,name:"1-month"},{id:3,name:"2-3-month"},{id:4,name:"0.5 year"},{id:5,name:"year"}]'

    end

    def getWantsData (z)
      @wants=z.want
      @wishlists=[]
      @wants.each do |w|
        @wishlists.push(w.wish_list)
      end
      @wishlists=@wishlists.to_json.html_safe
      @wants=@wants.to_json
    end

    def edit(options={}, &block)
      @zayavka_id=params[:id]
      @zayavka=Zayavka.find(@zayavka_id)
      #@haves=@zayavka.have
      @haves=Have.where(:zayavka_id=>@zayavka_id).to_json.html_safe

      @wants=@zayavka.want
      @wishlists=[]
      @wants.each do |w|
        @wishlists.push(w.wish_list)
      end
      @wishlists=@wishlists.to_json.html_safe
      @wants=@wants.to_json
      ######getWantsData(@zayavka)
      @zayavka=@zayavka.to_json
      getListData("edit")
      render :template=>'admin/_zayavka_crud',:formats => [:html],:layout =>"active_admin"

    end
    def new
        @action="new"
        @zayavka_id=0
        getListData("new")
        render :template=>'admin/_zayavka_crud',:formats => [:html],:layout =>"active_admin"
    end
    def show
      @action="show"
      @zayavka_id=params[:id]
      @objs = Obj.select("id,name").all.to_json
      ##@zayavka=Zayavka.find(@zayavka_id)
      @zayavka=Zayavka.fields_relation_name(@zayavka_id)[0].to_json.html_safe
      @zayavka_fields=Zayavka.column_names;
      @haves=Have.haves_relation_name(@zayavka_id.to_i).to_json.html_safe.gsub(/\n/,'')
      @havefields    = HaveField.select("id,name,field_name,field_ui_type").all.to_json

      @wants=Want.where("zayavka_id=?", @zayavka_id)
      @wishlists=[]
      @wants.each do |w|
        @wishlists.push(w.wish_list)
      end
      @wishlists=@wishlists.to_json.html_safe
      @wants=@wants.to_json
      ###########getWantsData(@zayavka)
      @dop_params    = DopParam.all.to_json
      render :template=>'admin/_zayavka_crud.html' ,:layout =>"active_admin"
    end
    def delete
      render :text=>"delete zayavka"
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
  batch_action :published do |selection|
    Zayavka.find(selection).each do |item|
      item.published=( item.published ==true)?false:true
      item.save!
    end
    redirect_to :back
  end
  #-------------------------------------------TABLE----------------------
  index :as=>:table do
    selectable_column
    id_column
    #column :id
    column :created_at, :sortable => :created_at do |rec|
      span rec.created_at.to_date
      if rec.have.length>=1 and rec.have[0].obmen_want !=nil and rec.have[0].obmen_want != 0
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
          rayon_str=h.rayon.name+", " if h.rayon != nil
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
            span floor_str
            br
            span s_str
            if h.sell_want != 0
              br span "(sel_want:"+h.price_want.to_s+" )"
            end
            a "more...", :href=>"javascript:alert('more...#{h.id}');"
            hr if h.variant_cnt >1
          end

        end
      end
      #out_str
    end
    column :want do |rec|
      if not rec.have.blank?
        if (not rec.have[0].sell_want.blank?)  and (not rec.have[0].price_want.blank?)
         span "sell_want:"+rec.have[0].price_want.to_s, :title=>"This is:\n "+(rec.have[0].price_want*8).to_s+" grn"
         br
        end
      else
        span "EMPTY"
      end
      out_str=""
      if not rec.want.blank?
        rec.want.each do |w|
          if (not w.obj.blank?)  and w.obj.id == 1 and (not w.price_want.blank?) # doplata
            span (w.obj.name+":"+w.price_want.to_s) if not w.price_want.blank?
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