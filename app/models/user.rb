require 'validates_timeliness'

class User < ApplicationRecord
  attr_accessor :login


  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  validates :username, presence: true, uniqueness: true
  # prevent username to include "@" to resolve potential confilict with username to be other's email
  validates_format_of :username, with: /^[a-zA-Z0-9_\.]*$/, :multiline => true
  # another backup validation
  validate :validate_username
  def validate_username
    if User.where(email: username).exists?
      errors.add(:username, :invalid)
    end
  end


  validates :first_name, presence: true
  validates :last_name, presence: true

  validates :birthday, presence: true, format: {with: /\d{4}\/\d{2}\/\d{2}/, message: "please use format YYYY/MM/DD"}
  validates_date :birthday, on_or_before: lambda {18.years.ago}

  validates :phone_number, presence: true, format: { with: /\d{3}-\d{3}-\d{4}/, message: "please use format xxx-xxx-xxxx" }

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :authentication_keys => [:login]
  has_many :orders, dependent: :destroy

  has_attached_file :avatar, styles: {
      thumb: '100x100>',
      square: '200x200#',
      medium: '300x300>'
  }
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_hash).where(["lower(username) = :value OR lower(email) = :value",{ :value => login.downcase }]).first
    elsif conditions.has_key?(:username) || conditions.has_key?(:email)
      where(conditions.to_hash).first
    end
  end



end
