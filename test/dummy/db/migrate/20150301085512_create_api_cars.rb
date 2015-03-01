class CreateApiCars < ActiveRecord::Migration
  def change
    create_table :api_cars do |t|
      t.string :name
      t.string :enrollment

      t.timestamps null: false
    end
  end
end
