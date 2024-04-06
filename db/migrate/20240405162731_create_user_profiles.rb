class CreateUserProfiles < ActiveRecord::Migration[7.1]
  def change
    create_table :user_profiles do |t|
      t.string :nickname
      t.text :bio
      t.string :favorite_game
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
