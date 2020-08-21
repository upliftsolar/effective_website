class CreateFaqs < ActiveRecord::Migration[6.0]
  def change
    create_table :faqs do |t|
      t.string :locale, default: 'es'
      t.text :question
      t.text :answer
      t.string :response_email
      t.boolean :archived, default: false
      t.integer :position, default: 100
      t.integer :activity_counter, default: 0
      t.boolean :featured, default: false
      t.datetime :created_at
      t.datetime :updated_at
    end
  end
end
