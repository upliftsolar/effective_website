class CreateCommunities < ActiveRecord::Migration[5.2]
  def change
    create_table :communities do |t|
      t.string :name
      t.string :phone
      t.string :email

      t.boolean :archived, default: false
      t.integer :mates_count, default: 0

      t.timestamps
    end
  end
end
