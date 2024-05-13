class CreateEnlightenedBeings < ActiveRecord::Migration[5.2]
  def up
    create_table :enlightened_beings do |t|
      t.string :name
      t.string :image_name
      t.text :about 
      t.datetime :birth_date
      t.datetime :mahasamadhi
      t.string :country
      t.string :adress
      t.boolean :alive 
      t.timestamps
    end
  end

  def down 
    drop_table :enlightened_beings
  end
end