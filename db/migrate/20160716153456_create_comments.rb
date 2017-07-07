class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :name
      t.string :email
      t.text :message
      t.datetime :message_date

      t.timestamps
    end
  end
end
