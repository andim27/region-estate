class RayonsAdminsController < ApplicationController
  # GET /rayons_admins
  # GET /rayons_admins.json
  def index
    @rayons_admins = RayonsAdmin.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @rayons_admins }
    end
  end

  # GET /rayons_admins/1
  # GET /rayons_admins/1.json
  def show
    @rayons_admin = RayonsAdmin.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @rayons_admin }
    end
  end

  # GET /rayons_admins/new
  # GET /rayons_admins/new.json
  def new
    @rayons_admin = RayonsAdmin.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @rayons_admin }
    end
  end

  # GET /rayons_admins/1/edit
  def edit
    @rayons_admin = RayonsAdmin.find(params[:id])
  end

  # POST /rayons_admins
  # POST /rayons_admins.json
  def create
    @rayons_admin = RayonsAdmin.new(params[:rayons_admin])

    respond_to do |format|
      if @rayons_admin.save
        format.html { redirect_to @rayons_admin, notice: 'Rayons admin was successfully created.' }
        format.json { render json: @rayons_admin, status: :created, location: @rayons_admin }
      else
        format.html { render action: "new" }
        format.json { render json: @rayons_admin.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /rayons_admins/1
  # PUT /rayons_admins/1.json
  def update
    @rayons_admin = RayonsAdmin.find(params[:id])

    respond_to do |format|
      if @rayons_admin.update_attributes(params[:rayons_admin])
        format.html { redirect_to @rayons_admin, notice: 'Rayons admin was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @rayons_admin.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rayons_admins/1
  # DELETE /rayons_admins/1.json
  def destroy
    @rayons_admin = RayonsAdmin.find(params[:id])
    @rayons_admin.destroy

    respond_to do |format|
      format.html { redirect_to rayons_admins_url }
      format.json { head :no_content }
    end
  end
end
