class CreateJoinTablePostCategory < ActiveRecord::Migration[6.0]
  def change
    create_join_table :posts, :categories do |t|
      t.index :post_id
      t.index :category_id
    end
  end
end
