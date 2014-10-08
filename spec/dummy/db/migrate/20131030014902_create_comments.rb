class CreateComments < ActiveRecord::Migration
  def up
    create_table :comments do |t|
      t.text    :content
      t.integer :user_id
      t.integer :recipe_id
      t.timestamps
    end

    add_index :comments, :user_id
    add_index :comments, :recipe_id
  end
end
