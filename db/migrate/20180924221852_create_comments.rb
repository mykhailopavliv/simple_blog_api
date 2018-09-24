class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.text :text
      t.integer :post_id

      t.timestamps
    end
    add_index :comments, :post_id
  end
end
