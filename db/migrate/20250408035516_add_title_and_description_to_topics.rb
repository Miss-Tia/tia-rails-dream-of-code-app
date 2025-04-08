class AddTitleAndDescriptionToTopics < ActiveRecord::Migration[8.0]
  def change
    add_column :topics, "title", :string
    add_column :topics, :description, :text
  end
end
