class ChangeDefaultLocaleToUsers < ActiveRecord::Migration[6.0]
  def change
    change_column_default :users, :locale, from: 'sp', to: 'es'
  end
end
