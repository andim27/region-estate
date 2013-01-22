class ZayavkasController < ApplicationController
  # GET /zayavkas
  # GET /zayavkas.json
  def index
    @zayavkas = Zayavka.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @zayavkas }
    end
  end

  # GET /zayavkas/1
  # GET /zayavkas/1.json
  def show
    @zayavka = Zayavka.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @zayavka }
    end
  end

  # GET /zayavkas/new
  # GET /zayavkas/new.json
  def new
    @zayavka = Zayavka.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @zayavka }
    end
  end

  # GET /zayavkas/1/edit
  def edit
    @zayavka = Zayavka.find(params[:id])
  end

  # POST /zayavkas
  # POST /zayavkas.json
  def create
  #  {"id":"","status_id":"1","name":"aaaaa","created_at":"","updated_at":"","tel_1":"34344545","tel_2":"56676778",
  #  "dop":"ddd","info_type_id":"1","info_source_id":"1","contact_id":"0","published":"1",
  #       "haves":[{"obj_id":"2","room":"1","price_estimate":"","price_want":"",
  #                "torg":0,"floor":"2","floor_house":"9","rayon_id":"0",
  #                 "street_id":"","house_n":"","flat_n":"","orientir":"",
  #                 "s_all":"","s_live":"","s_kux":"","state_id":"0",
  #                 "year":"","tel_1":"","dop":"","obmen_want":1,"sell_want":0,"rent_want":0},
  #                 {"obj_id":"2","room":"1","price_estimate":"","price_want":"","torg":0,
  #                "floor":"1","floor_house":"5","rayon_id":"0","street_id":"","house_n":"",
  #                "flat_n":"","orientir":"","s_all":"","s_live":"","s_kux":"","state_id":"0",
  #                "year":"","tel_1":"","dop":"","obmen_want":1,"sell_want":0,"rent_want":0}
  #               ],
  #     "wants":[{"variant":"1",
  #               "wishlist":[
  #                           {"field":"obj_id","cond":"=","value":"2"},
  #                           {"field":"room","cond":"=","value":"3"}
  #                          ]
  #             },
  #            {"variant":"1",
  #             "wishlist":[
  #                          {"field":"obj_id","cond":"=","value":"2"},
  #                          {"field":"room","cond":"=","value":"1"}
  #                        ]
  #             }
  #           ]
  #  }

   @zayavka_params=params["zayavka"]
   @haves=params["haves"]
   @wants=params["wants"]
   #render :text => "out="+@haves.inspect
   #return

   @zayavka = Zayavka.new(@zayavka_params)

   top_variant_id=0
    respond_to do |format|
     if @zayavka.save
        #---save have--------------
        if not @haves.empty?
              @haves.each_with_index do |item,index|
                ##item['id']          = 0
                item['room']          = item['room'] ==""?0:item['room'] #---check room input
                item['tel_1']         = item['tel_1'].to_s+((@zayavka['tel_1'].blank?)?"":@zayavka['tel_1'].to_s)+((@zayavka['tel_2'].blank?)?"":@zayavka['tel_2'].to_s)
                item['zayavka_id']    = @zayavka.id
                item['top_variant_id']= top_variant_id
                item['variant']       = index+1
                item['variant_cnt']   = @haves.length
                @have_rec = Have.new (item)

                if @have_rec.save
                  #render :text => "have_rec out="+@have_rec.inspect
                  #return
                  top_variant_id=@have_rec.id if index==0
                  if not @have_rec.update_attributes(:top_variant_id=>top_variant_id)
                     format.json { render json: @have_rec.errors, status: :unprocessable_entity }
                  end
                 else
                  format.json { render json: @have_rec.errors, status: :unprocessable_entity }
                end

              end
        end
        #---save want-----------------
        if @wants.empty?
           return
        end
        @wants.each_with_index do |item,index|
          #--get wants_params from POST
          ##render :text => "want variant="+variant+" wishlist= "+item['wishlist']
          ##return
          want_obj_id,want_room ,want_rayon_id, want_price_want=0,0,0,0
          item['wishlist'].each_with_index do |wish_list_item,wi|
                want_obj_id     = wish_list_item['value']    if wish_list_item['field']=="obj_id"
                want_room       = wish_list_item['value']    if wish_list_item['field']=="room"
                want_rayon_id   = wish_list_item['value']    if wish_list_item['field']=="rayon_id"
                want_price_want = wish_list_item['value']    if wish_list_item['field']=="price_want"

          end
          @want_rec=Want.new({:zayavka_id=>@zayavka.id,
                              :obj_id=>want_obj_id,
                              :room=>want_room,
                              :rayon_id=>want_rayon_id,
                              :price_want=>want_price_want,
                              :tel_1=>@zayavka["tel_1"],
                              :tel_2=>@zayavka["tel_2"]})
          if @want_rec.save
            #----wishlist uppend---
            variant=item['variant']
            w_list=item['wishlist']
            w_list.each do |row|
              @wish_list_rec=WishList.new({:want_id=>@want_rec.id,:field_name=>row['field'],:field_cond=>row['cond'],:field_value=>row['value'],:variant=>variant})
              if not @wish_list_rec.save
                format.json { render json: @wish_list_rec.errors, status: :unprocessable_entity }
              end
            end

          else
            format.json { render json: @want_rec.errors, status: :unprocessable_entity }
          end

        end
    #   format.html { redirect_to @zayavka, notice: 'Zayavka was successfully created.' }
        format.json { render json: @zayavka, status: :created, location: @zayavka }
      else
    #    format.html { render action: "new" }
        format.json { render json: @zayavka.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /zayavkas/1
  # PUT /zayavkas/1.json
  def update
    if params[:id].empty?
      @zayavka = Zayavka.find(params["zayavka"].id)
    else
      @zayavka = Zayavka.find(params[:id])
    end

    #render :text => "out id="+params[:zayavka].inspect
    #return

    items=params[:zayavka]
    respond_to do |format|
      if @zayavka.update_attributes(items)
        format.html { redirect_to @zayavka, notice: 'Zayavka was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @zayavka.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /zayavkas/1
  # DELETE /zayavkas/1.json
  def destroy
    @zayavka = Zayavka.find(params[:id])
    @zayavka.destroy

    respond_to do |format|
      format.html { redirect_to zayavkas_url }
      format.json { head :no_content }
    end
  end
end
