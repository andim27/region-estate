class HavesController < ApplicationController



  #protect_from_forgery :except => :uploadify

  # GET /haves
  # GET /haves.json
  def index
    @haves = Have.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @haves }
    end
  end

  # GET /haves/1
  # GET /haves/1.json
  def show
    @hafe = Have.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @hafe }
    end
  end

  # GET /haves/new
  # GET /haves/new.json
  def new
    @hafe = Have.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @hafe }
    end
  end

  # GET /haves/1/edit
  def edit
    @hafe = Have.find(params[:id])
  end

  # POST /haves
  # POST /haves.json
  def create
    @hafe = Have.new(params[:hafe])

    respond_to do |format|
      if @hafe.save
        format.html { redirect_to @hafe, notice: 'Have was successfully created.' }
        format.json { render json: @hafe, status: :created, location: @hafe }
      else
        format.html { render action: "new" }
        format.json { render json: @hafe.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /haves/1
  # PUT /haves/1.json
  def update
    @hafe = Have.find(params[:id])

    respond_to do |format|
      if @hafe.update_attributes(params[:hafe])
        if params[:plan_image].include?("Planirovki") #-----if choose from Planirovki-----
          @hafe.plan_image=File.open(Rails.root.to_s+params[:plan_image].gsub(/assets/,"/app/assets/images/"))
          @hafe.save
        end
        format.html { redirect_to @hafe, notice: 'Have was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @hafe.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /haves/1
  # DELETE /haves/1.json
  def destroy
    @hafe = Have.find(params[:id])
    @hafe.destroy

    respond_to do |format|
      ##format.html { redirect_to haves_url }
      format.json { head :no_content }
    end
  end

  #-Planirovki
  #config.assets.paths << "#{Rails.root}/app/assets/images/Planirovki"
  #  making it something such as application.js.erb,
  # $('#logo').attr({
  # src: "<%= asset_path('logo.png') %>"
  # });
  #def absolute_javascript_url(source)
  #   uri = URI.parse(root_url)
  #   uri.merge(javascript_path(source))
  #end
  #def image_url(source)
  #  "#{root_url}#{image_path(source)}"
  #end
  def planirovki
    #render :json=>"no files in:"
    #return
    # Rails.application.routes.url_helpers
    room =params[:id].to_i
    path=request.protocol + request.host_with_port
    if [1,2,3,4].include?(room)
        #path=request.protocol + request.host_with_port + "{Rails.root}/app/assets/images/Planirovki/#{room}-room/"
        path="app/assets/images/Planirovki/#{room}-room/"
        file_names=Dir.glob(path+'*.gif').map {|item| item=item.split('/').last}
    end
  ##rescue
    if not file_names.blank?
      render :json=>file_names.to_json
    else
      render :json=>"no files in:"+path +"room="+room+"  img path="+path
    end

  end

  #  upload plan
  #  ONLY IF HAVE RECORD EXIST!
  def uploadify
     type=params[:type]
     #render :text=>params.inspect
     #return
    if type=="plan"
      @have=Have.find(params[:id])
      @have.plan_image=params[:Filedata]
      ##@have.plan_image=params[@tempfile]
      @have.save!
      render :json=>'{"plan_image_url":"'+@have.plan_image_url+'"}'
    else
      render :text=>"not a pan file"+params.inspect
    end
  end
end
