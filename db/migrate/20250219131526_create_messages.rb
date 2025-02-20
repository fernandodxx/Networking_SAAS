class CreateMessages < ActiveRecord::Migration[8.0]
  def change
    create_table :messages do |t|
      t.integer :sender
      t.integer :receiver
      t.text :content
      t.datetime :read_at

      t.timestamps
    end
  end
end
