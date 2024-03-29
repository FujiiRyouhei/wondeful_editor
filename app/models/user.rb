# frozen_string_literal: true

class User < ApplicationRecord
  extend Devise::Models
  # Include default devise modules.
  devise :database_authenticatable, :registerable, :rememberable, :validatable
  #  :confirmable, :omniauthable, :trackable
  include DeviseTokenAuth::Concerns::User

  has_many :articles, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
end
