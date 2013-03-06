class AddNameToClients < ActiveRecord::Migration
  def change
    add_column :clients, :name, :string
    add_column :clients, :voice, :string
  end
end
