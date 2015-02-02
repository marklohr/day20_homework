class Doctor < ActiveRecord::Base

  has_many :patients, dependent: :destroy
  has_many :nurses, as: :nurseable

end
