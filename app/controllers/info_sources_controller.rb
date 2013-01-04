class InfoSourcesController < ApplicationController
  # GET /info_sources
  # GET /info_sources.json
  def index
    ##ActiveRecord::Base.include_root_in_json = false
    @info_sources = InfoSource.all
    render json: @info_sources ;

    #respond_to do |format|
    #  format.html # index.html.erb
    #  format.json { render json: @info_sources }
    #end
  end

  # GET /info_sources/1
  # GET /info_sources/1.json
  def show
    @info_source = InfoSource.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @info_source }
    end
  end

  # GET /info_sources/new
  # GET /info_sources/new.json
  def new
    @info_source = InfoSource.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @info_source }
    end
  end

  # GET /info_sources/1/edit
  def edit
    @info_source = InfoSource.find(params[:id])
  end

  # POST /info_sources
  # POST /info_sources.json
  def create
    @info_source = InfoSource.new(params[:info_source])

    respond_to do |format|
      if @info_source.save
        format.html { redirect_to @info_source, notice: 'Info source was successfully created.' }
        format.json { render json: @info_source, status: :created, location: @info_source }
      else
        format.html { render action: "new" }
        format.json { render json: @info_source.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /info_sources/1
  # PUT /info_sources/1.json
  def update
    @info_source = InfoSource.find(params[:id])

    respond_to do |format|
      if @info_source.update_attributes(params[:info_source])
        format.html { redirect_to @info_source, notice: 'Info source was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @info_source.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /info_sources/1
  # DELETE /info_sources/1.json
  def destroy
    @info_source = InfoSource.find(params[:id])
    @info_source.destroy

    respond_to do |format|
      format.html { redirect_to info_sources_url }
      format.json { head :no_content }
    end
  end
end
