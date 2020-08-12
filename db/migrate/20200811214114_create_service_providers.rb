class CreateServiceProviders < ActiveRecord::Migration[6.0]
  def change
    create_table :service_providers do |t|
      t.string :name
      t.string :address
      t.string :locality
      t.string :email
      t.string :phone
      t.string :title
      t.text :verifications
      t.text :flagged_text
      t.datetime :created_at
      t.datetime :updated_at
    end
  end
end
