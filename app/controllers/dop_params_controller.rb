class DopParamsController < ApplicationController
  # GET /dop_params
  # GET /dop_params.json
  def index
    @dop_params = DopParam.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @dop_params }
    end
  end

  # GET /dop_params/1
  # GET /dop_params/1.json
  def show
    @dop_param = DopParam.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @dop_param }
    end
  end

  # GET /dop_params/new
  # GET /dop_params/new.json
  def new
    @dop_param = DopParam.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @dop_param }
    end
  end

  # GET /dop_params/1/edit
  def edit
    @dop_param = DopParam.find(params[:id])
  end

  # POST /dop_params
  # POST /dop_params.json
  def create
    #@data='{"total":7,"rows":[
    #    {"id":1,"name":"All Tasks","begin":"3/4/2010","end":"3/20/2010","progress":60,"iconCls":"icon-ok"},
    #    {"id":2,"name":"Designing","begin":"3/4/2010","end":"3/10/2010","progress":100,"_parentId":1,"state":"closed"},
    #    {"id":21,"name":"Database","persons":2,"begin":"3/4/2010","end":"3/6/2010","progress":100,"_parentId":2},
    #    {"id":22,"name":"UML","persons":1,"begin":"3/7/2010","end":"3/8/2010","progress":100,"_parentId":2},
    #    {"id":23,"name":"Export Document","persons":1,"begin":"3/9/2010","end":"3/10/2010","progress":100,"_parentId":2},
    #    {"id":3,"name":"Coding","persons":2,"begin":"3/11/2010","end":"3/18/2010","progress":80},
    #    {"id":4,"name":"Testing","persons":1,"begin":"3/19/2010","end":"3/20/2010","progress":20}
    #],"footer":[
    #    {"name":"Total Persons:","persons":7,"iconCls":"icon-sum"}
    #]}'
    #
    #render json: @data
    #return
    @dop_param = DopParam.new(params[:dop_param])

    respond_to do |format|
      if @dop_param.save
        #format.html { redirect_to @dop_param, notice: 'Dop param was successfully created.' }
        format.json { render json: @dop_param, status: :created, location: @dop_param }
      else
        #format.html { render action: "new" }
        format.json { render json: @dop_param.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /dop_params/1
  # PUT /dop_params/1.json
  def update
    @dop_param = DopParam.find(params[:id])

    respond_to do |format|
      if @dop_param.update_attributes(params[:dop_param])
        #format.html { redirect_to @dop_param, notice: 'Dop param was successfully updated.' }
        #format.json { head :no_content }
        format.json { render json: @dop_param, status: :created, location: @dop_param }
      else
        #format.html { render action: "edit" }
        format.json { render json: @dop_param.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /dop_params/1
  # DELETE /dop_params/1.json
  def destroy
    @dop_param = DopParam.find(params[:id])
    @dop_param.destroy

    respond_to do |format|
      format.html { redirect_to dop_params_url }
      format.json { head :no_content }
    end
  end
  # CHECKED TREE
  # checkedtree
  def checkedtree
    @dop_params_rows = DopParam.select("id,_parentId,name,fields_list").all
  end
end
