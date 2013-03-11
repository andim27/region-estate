class InfoParserRulesController < ApplicationController
  # GET /info_parser_rules
  # GET /info_parser_rules.json
  def index
    @info_parser_rules = InfoParserRule.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @info_parser_rules }
    end
  end

  # GET /info_parser_rules/1
  # GET /info_parser_rules/1.json
  def show
    @info_parser_rule = InfoParserRule.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @info_parser_rule }
    end
  end

  # GET /info_parser_rules/new
  # GET /info_parser_rules/new.json
  def new
    @info_parser_rule = InfoParserRule.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @info_parser_rule }
    end
  end

  # GET /info_parser_rules/1/edit
  def edit
    @info_parser_rule = InfoParserRule.find(params[:id])
  end

  # POST /info_parser_rules
  # POST /info_parser_rules.json
  def create
    #@info_parser_rule = InfoParserRule.new(params[:info_parser_rule])
    @info_parser_rule = InfoParserRule.new(:p_field => params[:p_field],
                                           :p_rules => params[:p_rules],
                                           :id_info_source=>params[:id_info_source],
                                           :operation=>params[:operation],
                                           :kind=>params[:kind],
    )

    respond_to do |format|
      if @info_parser_rule.save
        #format.html { redirect_to @info_parser_rule, notice: 'Info parser rule was successfully created.' }
        format.json { render json: @info_parser_rule, status: :created, location: @info_parser_rule }
      else
        #format.html { render action: "new" }
        format.json { render json: @info_parser_rule.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /info_parser_rules/1
  # PUT /info_parser_rules/1.json
  def update
    @info_parser_rule = InfoParserRule.find(params[:id])

    respond_to do |format|
      if @info_parser_rule.update_attributes(params[:info_parser_rule])
        format.html { redirect_to @info_parser_rule, notice: 'Info parser rule was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @info_parser_rule.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /info_parser_rules/1
  # DELETE /info_parser_rules/1.json
  def destroy
    @info_parser_rule = InfoParserRule.find(params[:id])
    @info_parser_rule.destroy

    respond_to do |format|
      format.html { redirect_to info_parser_rules_url }
      format.json { head :no_content }
    end
  end
  #--b:get fields rules for grid
  def get_fields_rules
    #params[:id_info_source]
    items=Hash.new
    rows=HaveField.select("have_fields.name as p_field,(SELECT info_parser_rules.p_rules FROM info_parser_rules WHERE info_parser_rules.id_info_source =#{params[:id_info_source]}
AND info_parser_rules.operation=#{params[:operation]} AND info_parser_rules.kind=#{params[:kind]} AND info_parser_rules.id_have_field = have_fields.id
) AS p_rules").order("have_fields.parser_sort")
    ###rows=InfoParserRule.select("p_field,p_rules").where(:id_info_source=>params[:id_info_source],:operation=>params[:operation],:kind=>params[:kind])
    items[:total]=rows.size
    items[:rows]=rows
    render :json=>items.to_json
  end
  #--e:get fields rules for grid
  #---get rules---
  def get_parsed_rules
    items=InfoParserRule.where(:id_info_source=>params[:id_info_source],:operation=>params[:operation],:kind=>params[:kind])
    render :json=>items
  end
  #---post /info_parser_rules
  def parse_resource
    id_info_source = params[:id_info_source]
    if not id_info_source.blank?
        #require 'nokogiri'
        require 'open-uri'
        out_str=""
        info_s = InfoSource.find(id_info_source)
        url = info_s.p_url
        doc = Nokogiri::HTML(open(url))
        items=doc.css(info_s.p_container_tag).css(info_s.p_start_tag).each do |el|
          #out_str+=el.text+"\n"
        end
        render :text=>items.inspect
    else
      return
    end
  end
end
