class CreateNadYoga < ActiveRecord::Migration[5.2]
  def up
    create_table :nad_yogas do |t|
      t.string :title
      t.text :description
      t.string :image_name 
      t.references :enlightened_being, foreign_key: true
      t.string :reference_name 
      t.string :video

      t.timestamps
    end
  end

  def down 
    drop_table :nad_yogas
  end
end