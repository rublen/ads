class CreateAds < ActiveRecord::Migration[6.0]
  def up
    create_table :ads do |t|
      t.integer :user_id, null: false, index:true
      t.string :title, null: false
      t.text :description, null: false
      t.string :city, null: false
      t.float :lon
      t.float :lat

      t.timestamps
    end
  end

  def down
    drop_table :ads
  end
end
