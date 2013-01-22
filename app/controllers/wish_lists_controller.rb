class WishListsController < ApplicationController
  # GET /wish_lists
  # GET /wish_lists.json
  def index
    @wish_lists = WishList.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @wish_lists }
    end
  end

  # GET /wish_lists/1
  # GET /wish_lists/1.json
  def show
    @wish_list = WishList.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @wish_list }
    end
  end

  # GET /wish_lists/new
  # GET /wish_lists/new.json
  def new
    @wish_list = WishList.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @wish_list }
    end
  end

  # GET /wish_lists/1/edit
  def edit
    @wish_list = WishList.find(params[:id])
  end
   #--------------------------take obj_id from wishlist and set them like main
   #noinspection RubyEmptyRescueBlockInspection
  def setMainWantAttribute (w_id)

    w_rec=Want.find(w_id)
    wishlists=w_rec.wish_list
    wishlists.each do |item|
        w_rec.obj_id      = item['field_value']   if item['field_name'] =='obj_id'
        w_rec.room        = item['field_value']    if item['field_name'] =='room'
        w_rec.price_want  = item['field_value']    if item['field_name'] =='price_want'
        w_rec.variant     = item['field_value']    if item['field_name'] =='variant'
        w_rec.save()

    end
  rescue
    logger.info "setMainWantAttr - error w_id="+w_id.to_s
  end
  # POST /wish_lists
  # POST /wish_lists.json
  def create
    @wish_list = params
    @zayavka_id=params["zayavka_id"]
    @wish_list.delete("action")
    @wish_list.delete("controller")
    @wish_list.delete("wish_list")

    #----save wishlist-----------------------------
    @wish_list.each do |key,item|
      if item.blank?
        next
      end
      if item["id"].blank? #---added-------------------------------
        if item["want_id"].blank?
           if @want_id.blank?
               #---need add new ec to want
             w_rec=Want.new(:zayavka_id=>item["zayavka_id"])
             w_rec.save()
             @want_id=w_rec.id
           end
           item["want_id"]=@want_id
           item.delete("zayavka_id")
        else
          @want_id=item["want_id"]
        end
        item.delete("zayavka_id")
        @wl_rec=WishList.new(item)
        if not @wl_rec.save()
          render  json: @wish_list.errors, status: :unprocessable_entity
        end
      else  #----update------------------------------------------------
        @wl_rec=WishList.find(item["id"])
        if not @wl_rec.update_attributes(item)
           render  json: @wish_list.errors, status: :unprocessable_entity
        end
      end
      @want_id=item["want_id"]
    end
    logger.info "setMainWantAttr  w_id="+@want_id.to_s
    self.setMainWantAttribute(@want_id) if not @want_id.blank?
    #render :text=>@wish_list.inspect
    #return
    respond_to do |format|
      format.json { head :no_content }
    end

  end

  # PUT /wish_lists/1
  # PUT /wish_lists/1.json
  def update
    @wish_list = WishList.find(params[:id])
    render :text=>params.inspect
    return
    #respond_to do |format|
    #  if @wish_list.update_attributes(params[:wish_list])
    #    format.html { redirect_to @wish_list, notice: 'Wish list was successfully updated.' }
    #    format.json { head :no_content }
    #  else
    #    format.html { render action: "edit" }
    #    format.json { render json: @wish_list.errors, status: :unprocessable_entity }
    #  end
    #end
  end

  # DELETE /wish_lists/1
  # DELETE /wish_lists/1.json
  def destroy
    @wish_list = WishList.find(params[:id])
    @wish_list.destroy

    respond_to do |format|
      #format.html { redirect_to wish_lists_url }
      format.json { head :no_content }
    end
  end
end
