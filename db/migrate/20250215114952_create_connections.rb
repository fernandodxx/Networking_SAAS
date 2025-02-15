class CreateConnections < ActiveRecord::Migration[8.0]
  def change
    create_table :connections do |t|
      t.references :user, null: false, foreign_key: true
      t.references :connected_user, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
