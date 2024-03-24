# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password
  has_many :personal_orders, dependent: :destroy
  has_and_belongs_to_many :products

  before_save :capitalize_name, :capitalize_surname

  validates :phone_number, presence: true, uniqueness: true, format: { with: /\A\+\d+\z/ }, length: { is: 13 }
  validates :password, confirmation: true, length: { minimum: 6, maximum: 70 }, if: :password_validation_required?
  validates :name, presence: true, length: { minimum: 2, maximum: 40 }
  validates :surname, presence: true, length: { minimum: 2, maximum: 40 }

  private

  def capitalize_name
    self.name = name.capitalize
  end

  def capitalize_surname
    self.surname = surname.capitalize
  end  

  def password_validation_required?
    new_record? || password_digest_changed?
  end
end
