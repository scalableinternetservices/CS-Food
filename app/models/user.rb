class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :birthday, presence: true, format: {with: /\d{4}\/\d{2}\/\d{2}/, message: "please use format YYYY/MM/DD"}
  validates :phone_number, presence: true, format: { with: /\d{3}-\d{3}-\d{4}/, message: "please use format xxx-xxx-xxxx" }

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :orders, dependent: :destroy
end
