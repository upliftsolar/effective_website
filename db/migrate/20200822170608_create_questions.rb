class CreateQuestions < ActiveRecord::Migration[6.0]
  def change
    create_table :questions do |t|
      t.string :locale, default: "en"
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
