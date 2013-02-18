class CreateWebsites < ActiveRecord::Migration
  def change
    create_table :websites do |t|
      t.string :tytul
      t.text :kod_strony

      t.timestamps
    end
  end
end
