class CreateSubmissions < ActiveRecord::Migration[8.0]
  def change
    create_table :submissions do |t|
      t.references :enrollment, null: false, foreign_key: true
      t.references :lesson, null: false, foreign_key: true
      t.text :content
      t.string :url
      t.timestamps
    end
  end
end
