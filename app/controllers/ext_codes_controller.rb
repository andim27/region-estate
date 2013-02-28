class ExtCodesController < ApplicationController
  # GET /ext_codes
  # GET /ext_codes.json
  def index
    @ext_codes = ExtCode.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @ext_codes }
    end
  end

  # GET /ext_codes/1
  # GET /ext_codes/1.json
  def show
    @ext_code = ExtCode.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @ext_code }
    end
  end

  # GET /ext_codes/new
  # GET /ext_codes/new.json
  def new
    @ext_code = ExtCode.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @ext_code }
    end
  end

  # GET /ext_codes/1/edit
  def edit
    @ext_code = ExtCode.find(params[:id])
  end

  # POST /ext_codes
  # POST /ext_codes.json
  def create
    @ext_code = ExtCode.new(params[:ext_code])

    respond_to do |format|
      if @ext_code.save
        format.html { redirect_to @ext_code, notice: 'Ext code was successfully created.' }
        format.json { render json: @ext_code, status: :created, location: @ext_code }
      else
        format.html { render action: "new" }
        format.json { render json: @ext_code.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /ext_codes/1
  # PUT /ext_codes/1.json
  def update
    @ext_code = ExtCode.find(params[:id])

    respond_to do |format|
      if @ext_code.update_attributes(params[:ext_code])
        format.html { redirect_to @ext_code, notice: 'Ext code was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @ext_code.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ext_codes/1
  # DELETE /ext_codes/1.json
  def destroy
    @ext_code = ExtCode.find(params[:id])
    @ext_code.destroy

    respond_to do |format|
      format.html { redirect_to ext_codes_url }
      format.json { head :no_content }
    end
  end

  # ---get ext codes for grid view
  def get_ext_codes
    name_table=params[:name_table]
    res=Hash.new
    if name_table == "rayons"
       items=Rayon.select("rayons.id as id_table,rayons.name,(SELECT code FROM ext_codes WHERE ext_codes.id_info_source=#{params[:id_info_source]} and ext_codes.id_table=rayons.id) as code").from("rayons,ext_codes").where("rayons.parent=2775").page(params[:page]).per(params[:rows])
       res[:total]=Rayon.where("rayons.parent=2775").count
    end
    if name_table =="objs"
       items=Obj.select("DISTINCT objs.id as id_table,objs.name,(SELECT code FROM ext_codes WHERE ext_codes.id_info_source=#{params[:id_info_source]} and ext_codes.id_table=objs.id) as code").from("objs,ext_codes")
       res[:total]=Obj.count
    end
    if name_table =="states"
      items=State.select("id as id_table,name").all
      res[:total]=State.count
    end

    res[:rows]=items
    render :json=>res.to_json
  rescue Exception => e
    render :text=>"Error:"+e.backtrace
  end

  # --- save ext code
  def save_code

    name_table=params[:name_table]

    if name_table =="rayons"
      id_table=params[:id_table]
      ext_code_rec= ExtCode.where(:id_table=>id_table,:name_table=>name_table,:id_info_source=>params[:id_info_source])
      if ext_code_rec.count >0

        ext_code_rec[0].update_attributes(:name_table=>name_table,:id_table=>id_table,:id_info_source=>params[:id_info_source],:code=>params[:code])
      else
         ExtCode.create(:name_table=>name_table,:id_table=>id_table,:id_info_source=>params[:id_info_source],:code=>params[:code])
      end
      render :text=>"Saved!"
    end
  rescue Exception => e
    render :text=>"Error:"+e.backtrace
  end
end
