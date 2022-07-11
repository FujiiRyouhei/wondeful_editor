# frozen_string_literal: true

class DeviseTokenAuthCreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :user do |t|
      # user info
      t.string :name
      t.string :email
      t.string :encrypted_password

      t.timestamps
    end
  end
end
