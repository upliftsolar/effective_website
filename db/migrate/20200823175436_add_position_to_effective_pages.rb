class AddPositionToEffectivePages < ActiveRecord::Migration[6.0]
  def change
    add_column :pages, :position, :integer, default: 100
  end
end
