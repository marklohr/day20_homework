class Nurse < ActiveRecord::Base
  belongs_to :nurseable, polymorphic: true
end
# nurseable_type : string
# nurseable_id : integer


