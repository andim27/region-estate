class HaveFieldsController < InheritedResources::Base
  # GET /HaveFields
  # GET /HaveFields.json
  def index
    @HaveFields = HaveField.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @HaveFields }
    end
  end

  # GET /HaveFields/1
  # GET /HaveFields/1.json
  def show
    @hafe = HaveField.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @hafe }
    end
  end

  # GET /HaveFields/new
  # GET /HaveFields/new.json
  def new
    @hafe = HaveField.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @hafe }
    end
  end

  # GET /HaveFields/1/edit
  def edit
    @hafe = HaveField.find(params[:id])
  end

  # POST /HaveFields
  # POST /HaveFields.json
  def create
    @hafe = HaveField.new(params[:hafe])

    respond_to do |format|
      if @hafe.save
        format.html { redirect_to @hafe, notice: 'HaveField was successfully created.' }
        format.json { render json: @hafe, status: :created, location: @hafe }
      else
        format.html { render action: "new" }
        format.json { render json: @hafe.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /HaveFields/1
  # PUT /HaveFields/1.json
  def update
    @hafe = HaveField.find(params[:id])

    respond_to do |format|
      if @hafe.update_attributes(params[:hafe])
        format.html { redirect_to @hafe, notice: 'HaveField was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @hafe.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /HaveFields/1
  # DELETE /HaveFields/1.json
  def destroy
    @hafe = HaveField.find(params[:id])
    @hafe.destroy

    respond_to do |format|
      format.html { redirect_to HaveFields_url }
      format.json { head :no_content }
    end
  end
end


