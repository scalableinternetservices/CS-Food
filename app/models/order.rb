class Order < ApplicationRecord
  validates :title, presence: true,
            length: { minimum: 5, maximum: 30 }
  validates :text, presence: true
  belongs_to :user
end
