class Place < ActiveRecord::Base
  has_many :check_ins
  has_many :table_models, through: :place_table_models
  has_many :place_table_models
end
