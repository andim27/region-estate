class ContactsController < ApplicationController
  # GET /contacts
  # GET /contacts.json
  def index
    @contacts = Contact.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @contacts }
    end
  end

  # GET /contacts/1
  # GET /contacts/1.json
  def show
    @contact = Contact.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @contact }
    end
  end

  # GET /contacts/new
  # GET /contacts/new.json
  def new
    @contact = Contact.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @contact }
    end
  end

  # GET /contacts/1/edit
  def edit
    @contact = Contact.find(params[:id])
  end

  # POST /contacts
  # POST /contacts.json
  def create
    @contact = Contact.new(params[:contact])

    respond_to do |format|
      if @contact.save
        format.html { redirect_to @contact, notice: 'Contact was successfully created.' }
        format.json { render json: @contact, status: :created, location: @contact }
      else
        format.html { render action: "new" }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /contacts/1
  # PUT /contacts/1.json
  def update
    @contact = Contact.find(params[:id])

    respond_to do |format|
      if @contact.update_attributes(params[:contact])
        format.html { redirect_to @contact, notice: 'Contact was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contacts/1
  # DELETE /contacts/1.json
  def destroy
    @contact = Contact.find(params[:id])
    @contact.destroy

    respond_to do |format|
      format.html { redirect_to contacts_url }
      format.json { head :no_content }
    end
  end

  #-----Check tel
  def checktel

    cond_obj=Hash.new
    if params[:type] =="local"
      if not params[:tel_1].blank?
      where_str="(tel_mob_1 LIKE '%:tel_1%') OR (tel_mob_2 LIKE '%:tel_1%') OR (tel_mob_3 LIKE '%:tel_1%')"
      cond_obj={:tel_1=>params[:tel_1]}
      if not params[:tel_2].blank?
        where_str << " OR (tel_mob_1 LIKE '%:tel_2%') OR (tel_mob_2 LIKE '%:tel_2%') OR (tel_mob_3 LIKE '%:tel_2%')"
        cond_obj={:tel_1 => params[:tel_1].to_i, :tel_2 => params[:tel_2].to_i}
      end
      res=Contact.select("id").where(where_str,cond_obj)
     end
    end
    render :text=>"tel"+res.inspect
  end
end
