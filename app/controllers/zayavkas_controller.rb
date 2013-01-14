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

    #render :text => "out="+params.inspect
    #return
   @zayavka_params=params["zayavka"]
   @haves=params["haves"]
   @wants=params["wants"]


   @zayavka = Zayavka.new(@zayavka_params)


    respond_to do |format|
     if @zayavka.save
    #    format.html { redirect_to @zayavka, notice: 'Zayavka was successfully created.' }
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
    @zayavka = Zayavka.find(params[:id])
    render :text => "out id="+params[:id]
    #respond_to do |format|
    #  if @zayavka.update_attributes(params[:zayavka])
    #    format.html { redirect_to @zayavka, notice: 'Zayavka was successfully updated.' }
    #    format.json { head :no_content }
    #  else
    #    format.html { render action: "edit" }
    #    format.json { render json: @zayavka.errors, status: :unprocessable_entity }
    #  end
    #end
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
