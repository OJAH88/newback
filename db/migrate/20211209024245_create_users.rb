class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :username
      t.string :password_digest
      t.string :name
      t.string :email
      t.integer :age
      t.integer :friends_count
      t.integer :pokes_count
      t.integer :posts_count
      t.integer :messages_count
      t.string :city
      t.string :state
      t.string :bio
      t.string :hobbies
      t.string :likes
      t.string :imgurl

      t.timestamps
    end
  end
end