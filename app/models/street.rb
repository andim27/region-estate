class Street < ActiveRecord::Base
   #set_table_name "kharkov_streets_ukrs"
   ##attr_accessible :id, :name, :name_rus, :center_lat, :center_lng
   #has_many :rel_rayons_admins_streets_ukrs
   #has_many :rayons_admins, :through => :rel_rayons_admins_streets_ukrs
    has_and_belongs_to_many :rayons_admins
    has_and_belongs_to_many :rayons, :finder_sql=>proc { "SELECT rayons.* FROM rayons,rayons_streets WHERE rayons_streets.street_id=#{id} AND rayons.id=rayons_streets.rayon_id"}
    has_one :have

    def self.getRayonsStr(s_id)
      #rec=where(:street_id=>st.id)
      #out=""
      #rec.each do |item|
      #     out=out+Rayon.find(item.rayon_id).name+": "
      #end
      #out
      rec=rayons.where(:street_id=>s_id)
      Rayon.find(rec.rayon_id).name
    end
    def self.getStreetsInRayon(r_id,fields=nil)
       if fields ==nil
         fields_str="s.*"
       else
         fields_str=fields.map{|el| "s."+el.to_s}.join(",")
       end
      Street.find_by_sql("SELECT #{fields_str} FROM streets as s,rayons_streets as rs WHERE s.id=rs.street_id AND rs.rayon_id=#{r_id}")
    end

end
