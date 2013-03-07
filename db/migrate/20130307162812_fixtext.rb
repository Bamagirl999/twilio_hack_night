class Fixtext < ActiveRecord::Migration
  def up
  		change_column :clients, :message, :text
  end

  def down
  end
end
