class CreateFeatures < ActiveRecord::Migration[6.1]
  def change
    create_table :features do |t|
      t.string :external_id
      t.decimal :magnitude, precision: 15, scale: 10
      t.string :place
      t.string :time
      t.boolean :tsunami, default: false
      t.string :mag_type
      t.string :title
      t.decimal :longitude, precision: 20, scale: 15
      t.decimal :latitude, precision: 20, scale: 15
      t.string :external_url

      t.timestamps
    end
  end
end
