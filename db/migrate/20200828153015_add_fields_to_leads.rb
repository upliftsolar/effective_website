class AddFieldsToLeads < ActiveRecord::Migration[6.0]
  def change
    add_column :leads, :full_name, :string
    add_column :leads, :contact_info, :string
    add_column :leads, :purpose, :string
    add_column :leads, :body, :text
  end
end
