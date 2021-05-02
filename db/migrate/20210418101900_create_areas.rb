class CreateAreas < ActiveRecord::Migration[5.2]
  def change
    create_table :areas do |t|
      t.string :prefecture, null: false
      t.string :district, null: false

      t.timestamps
    end
  end
end
