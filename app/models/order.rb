class Order < ApplicationRecord
  has_many :order_items
  has_many :items, through: :order_items
  belongs_to :user

  validates :title, presence: true,
            length: { minimum: 5, maximum: 30 }
  validates :points, presence: true,
            numericality: { only_integer: true },
            numericality: { greater_than_or_equal_to: 0}
  validate :check_my_points_gte_order_points

  def check_my_points_gte_order_points
    errors.add(:points, "ya goofed") if self.points > self.user.points
  end
end
