class PlaceTableModel < ActiveRecord::Base
  belongs_to :place
  belongs_to :table_model
end
