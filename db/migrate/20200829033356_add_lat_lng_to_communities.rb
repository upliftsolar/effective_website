class AddLatLngToCommunities < ActiveRecord::Migration[6.0]
  def change
    add_column :communities, :lat, :float
    add_column :communities, :lng, :float
    add_column :communities, :locality, :string
  end
end
