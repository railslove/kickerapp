class CreatePlaceTableModels < ActiveRecord::Migration
  def change
    create_table :place_table_models do |t|
      t.integer :place_id
      t.integer :table_model_id
    end

    add_index :place_table_models, :place_id
    add_index :place_table_models, :table_model_id
  end
end
