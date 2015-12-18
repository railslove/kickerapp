class TableModel < ActiveRecord::Base
  has_many :places, through: :place_table_models
  has_many :place_table_models
end
