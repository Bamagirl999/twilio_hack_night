class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.string :phone
      t.string :message

      t.timestamps
    end
  end
end
