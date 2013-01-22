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

  # POST /wish_lists
  # POST /wish_lists.json
  def create
    @wish_list = params
    @zayavka_id=params["zayavka_id"]
    @wish_list.delete("action")
    @wish_list.delete("controller")
    @wish_list.delete("wish_list")
    @wish_list.each do |key,item|
      if item.blank?
        next
      end
      if item["id"].blank? #---added--
        if item["want_id"].blank?
           if @want_id.blank?
               #---need add new ec to want
             w_rec=Want.new(:zayavka_id=>item["zayavka_id"])
             w_rec.save()
             @want_id=w_rec.id
           end
           item["want_id"]=@want_id
           item.delete("zayavka_id")
        end

        @wl_rec=WishList.new(item)
        if not @wl_rec.save()
          render  json: @wish_list.errors, status: :unprocessable_entity
        end
      else
        @wl_rec=WishList.find(item["id"])
        if not @wl_rec.update_attributes(item)
           render  json: @wish_list.errors, status: :unprocessable_entity
        end
      end

    end
    #render :text=>@wish_list.inspect
    #return
    respond_to do |format|
      format.json { head :no_content }
    end
    #respond_to do |format|
    #  if @wish_list.save
    #    format.html { redirect_to @wish_list, notice: 'Wish list was successfully created.' }
    #    format.json { render json: @wish_list, status: :created, location: @wish_list }
    #  else
    #    format.html { render action: "new" }
    #    format.json { render json: @wish_list.errors, status: :unprocessable_entity }
    #  end
    #end
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
