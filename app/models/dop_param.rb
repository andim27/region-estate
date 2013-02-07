class DopParam < ActiveRecord::Base
   #------name in one string------
   #---SELECT group_concat(convert(dp.name,char(15)))as str FROM dop_params as dp WHERE ( "3,5,6,12,15,8,9" LIKE concat("%",cast(dp.id as char),"%") )

end
