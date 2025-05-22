class CreateSubmissions < ActiveRecord::Migration[8.0]
  def change
    create_table :submissions do |t|
      t.references :lesson, null: false, foreign_key: true
      t.references :student, null: false, foreign_key: true
      t.references :mentor, null: false, foreign_key: true
      t.text :content
      t.datetime :submitted_at

      t.timestamps
    end
  end
end
