class AddEmailToArticles < ActiveRecord::Migration[6.0]
  def change
    add_column :articles, :status, :integer, default: 0, null: false
  end
end
