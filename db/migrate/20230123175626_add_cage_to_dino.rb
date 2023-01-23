class AddCageToDino < ActiveRecord::Migration[7.0]
  def change
    add_reference :dinos, :cage, null: false, foreign_key: true
  end
end
