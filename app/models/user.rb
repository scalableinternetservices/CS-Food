require 'validates_timeliness'

class User < ApplicationRecord
  attr_accessor :login

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :birthday, presence: true

  validates :phone_number, presence: true

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :authentication_keys => [:login]

  has_many :orders, dependent: :destroy

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_hash).where(["lower(email) = :value", {:value => login.downcase}]).first
    elsif conditions.has_key?(:email)
      where(conditions.to_hash).first
    end
  end


end
