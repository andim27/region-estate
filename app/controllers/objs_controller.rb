class ObjsController < ApplicationController
  # GET /objs
  # GET /objs.json
  def index
    @objs = Obj.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @objs }
    end
  end

  # GET /objs/1
  # GET /objs/1.json
  def show
    @obj = Obj.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @obj }
    end
  end

  # GET /objs/new
  # GET /objs/new.json
  def new
    @obj = Obj.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @obj }
    end
  end

  # GET /objs/1/edit
  def edit
    @obj = Obj.find(params[:id])
  end

  # POST /objs
  # POST /objs.json
  def create
    @obj = Obj.new(params[:obj])

    respond_to do |format|
      if @obj.save
        format.html { redirect_to @obj, notice: 'Obj was successfully created.' }
        format.json { render json: @obj, status: :created, location: @obj }
      else
        format.html { render action: "new" }
        format.json { render json: @obj.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /objs/1
  # PUT /objs/1.json
  def update
    @obj = Obj.find(params[:id])

    respond_to do |format|
      if @obj.update_attributes(params[:obj])
        format.html { redirect_to @obj, notice: 'Obj was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @obj.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /objs/1
  # DELETE /objs/1.json
  def destroy
    @obj = Obj.find(params[:id])
    @obj.destroy

    respond_to do |format|
      format.html { redirect_to objs_url }
      format.json { head :no_content }
    end
  end
end
