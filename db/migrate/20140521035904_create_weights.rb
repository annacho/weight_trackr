class CreateWeights < ActiveRecord::Migration
  def change
    create_table :weights do |t|
    	t.date "weight_date"
    	t.time "weight_time"
    	t.float "weight"
    	t.string "notes"
    end
  end
end
