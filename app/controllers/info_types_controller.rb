class InfoTypesController < ApplicationController
  # GET /info_types
  # GET /info_types.json
  def index
    @info_types = InfoType.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @info_types }
    end
  end

  # GET /info_types/1
  # GET /info_types/1.json
  def show
    @info_type = InfoType.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @info_type }
    end
  end

  # GET /info_types/new
  # GET /info_types/new.json
  def new
    @info_type = InfoType.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @info_type }
    end
  end

  # GET /info_types/1/edit
  def edit
    @info_type = InfoType.find(params[:id])
  end

  # POST /info_types
  # POST /info_types.json
  def create
    @info_type = InfoType.new(params[:info_type])

    respond_to do |format|
      if @info_type.save
        format.html { redirect_to @info_type, notice: 'Info type was successfully created.' }
        format.json { render json: @info_type, status: :created, location: @info_type }
      else
        format.html { render action: "new" }
        format.json { render json: @info_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /info_types/1
  # PUT /info_types/1.json
  def update
    @info_type = InfoType.find(params[:id])

    respond_to do |format|
      if @info_type.update_attributes(params[:info_type])
        format.html { redirect_to @info_type, notice: 'Info type was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @info_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /info_types/1
  # DELETE /info_types/1.json
  def destroy
    @info_type = InfoType.find(params[:id])
    @info_type.destroy

    respond_to do |format|
      format.html { redirect_to info_types_url }
      format.json { head :no_content }
    end
  end
end
