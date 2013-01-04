class RayonsController < ApplicationController
  # GET /rayons
  # GET /rayons.json
  def index
    @rayons = Rayon.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @rayons }
    end
  end

  # GET /rayons/1
  # GET /rayons/1.json
  def show
    @rayon = Rayon.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @rayon }
    end
  end

  # GET /rayons/new
  # GET /rayons/new.json
  def new
    @rayon = Rayon.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @rayon }
    end
  end

  # GET /rayons/1/edit
  def edit
    @rayon = Rayon.find(params[:id])
  end

  # POST /rayons
  # POST /rayons.json
  def create
    @rayon = Rayon.new(params[:rayon])

    respond_to do |format|
      if @rayon.save
        format.html { redirect_to @rayon, notice: 'Rayon was successfully created.' }
        format.json { render json: @rayon, status: :created, location: @rayon }
      else
        format.html { render action: "new" }
        format.json { render json: @rayon.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /rayons/1
  # PUT /rayons/1.json
  def update
    @rayon = Rayon.find(params[:id])

    respond_to do |format|
      if @rayon.update_attributes(params[:rayon])
        format.html { redirect_to @rayon, notice: 'Rayon was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @rayon.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rayons/1
  # DELETE /rayons/1.json
  def destroy
    @rayon = Rayon.find(params[:id])
    @rayon.destroy

    respond_to do |format|
      format.html { redirect_to rayons_url }
      format.json { head :no_content }
    end
  end
end
