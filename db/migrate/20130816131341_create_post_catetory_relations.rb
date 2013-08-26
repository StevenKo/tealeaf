class CreatePostCatetoryRelations < ActiveRecord::Migration
  def change
    create_table :post_catetory_relations do |t|
      t.integer :post_id
      t.integer :category_id
      t.timestamps
    end
  end
end
