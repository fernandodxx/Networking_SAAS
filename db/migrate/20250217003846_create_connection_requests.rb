class CreateConnectionRequests < ActiveRecord::Migration[8.0]
  def change
    create_table :connection_requests do |t|
      t.references :sender, foreign_key: { to_table: :users }
      t.references :receiver, foreign_key: { to_table: :users }
      t.string :status, default: "pending"

      t.timestamps
    end
  end
end
