class CreateRecipes < ActiveRecord::Migration
  def up
    create_table :recipes do |t|
      t.string  :name
      t.text    :description
      t.string  :image_url
      t.integer :user_id
      t.timestamps
    end

    add_index :recipes, :user_id
  end
end
