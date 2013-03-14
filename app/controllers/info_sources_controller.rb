class InfoSourcesController < ApplicationController

  MAX_SESSION_TIME = 60 * 60 #--my--s
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
     # if @info_source.update_attributes(params[:info_source])
      params.delete(:action)
      params.delete(:controller)
      #
      #render :text=>params.inspect
      #return
      if @info_source.update_attributes(params)
        # format.html { redirect_to @info_source, notice: 'Info source was successfully updated.' }
        format.json { head :no_content }
      else
        # format.html { render action: "edit" }
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

  # parser
  # '{"total":"11","rows":[{"id":"255004","firstname":"test","lastname":"blubber","phone":"33333333","email":""},{"id":"255006","firstname":"juan","lastname":"lopez","phone":"2251","email":""},{"id":"255009","firstname":"lkj","lastname":"lkj","phone":"lkj","email":"asdf@asd.com"},{"id":"255014","firstname":"SASDFF","lastname":"SFSDAA","phone":"","email":""},{"id":"255016","firstname":"cvxcb","lastname":"dfgdf","phone":"5454","email":"dgdf@de.de"},{"id":"255017","firstname":"sfsdfsd","lastname":"sdfsd","phone":"dds","email":"dgdf@de.de"},{"id":"255018","firstname":"sdfsd","lastname":"dsfsdf","phone":"fsd","email":"dgdf@de.de"},{"id":"255019","firstname":"fsdfssdf","lastname":"sdfsd","phone":"sdfsd","email":"dgdf@de.de"},{"id":"255020","firstname":"qsdqs","lastname":"qsdqs","phone":"qsdqsd","email":"dgdf@de.de"},{"id":"255021","firstname":"dsqd","lastname":"qsdqs","phone":"qsdqs","email":"dgdf@de.de"}]}'
  def get_parsed_list
     res=Hash.new
     ##items=InfoSource.select("DISTINCT info_sources.*,ipr.id as info_sources_id ").where("info_url <>''").joins("LEFT JOIN info_parser_rules as ipr ON ipr.id_info_source=info_sources.id").page(params[:page]).per(params[:rows])
     infoS=InfoSource
     infoS=infoS.select("info_sources.*")
     infoS=infoS.where("info_type = ?",params[:info_type]) if params[:info_type].to_i != 0
     infoS=infoS.where("info_url <>''")
     res[:total]=infoS.size ##InfoSource.where("info_url <>''").size
     items=infoS.page(params[:page]).per(params[:rows])
     #--items=infoS.select("info_sources.*").where("info_url <>''").page(params[:page]).per(params[:rows])

     res[:rows]=items

     if !session[:expiry_time].nil? and session[:expiry_time] < Time.now
       # Session has expired. Clear the current session.
       reset_session
     end
     # Assign a new expiry time, whether the session has expired or not.
     session[:expiry_time] = MAX_SESSION_TIME.seconds.from_now

     render :json=>res
  end
end
