class CreateLeads < ActiveRecord::Migration[6.0]
  def change
    create_table :leads do |t|
      t.string :locality
      t.references :created_by
      t.datetime :created_at
      t.datetime :updated_at
    end
  end
end
