class TranslateController < ApplicationController
  attr_reader :street

  def index
	  #@items = Street.all
	  #@items.each {|item|
	  #
	  #	render :text => "Translate<br>" +item.name
    #echo item.name
	  #
	  #}
	beginning = Time.now
	File.open("d:/trans_streets_rus_utf8.txt").each {|line|
	  id = line.split(",")[0].to_i
	  name_rus =line.split(",")[1]
	  if id != 0
	     @street = Street.find(id)
	     @street.update_attributes(:name_rus =>name_rus) 
          end
	}
	render :text => "Translate: Time elapsed #{Time.now - beginning} sec<br>"
	end
end
