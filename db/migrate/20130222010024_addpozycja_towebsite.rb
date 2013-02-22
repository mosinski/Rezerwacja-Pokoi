class AddpozycjaTowebsite < ActiveRecord::Migration
  def self.up
    add_column :websites, :pozycja, :string
  end
 
  def self.down
    remove_column :websites, :pozycja
  end
end
