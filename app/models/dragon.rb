class Dragon < ActiveRecord::Base

  COLORS = %w(red blue green gold black)
  SEX = %w(M F)

  validates :age, :birth_date, :color, :name, :sex, :description, presence: true
  validates :age, numericality: { only_integer: true}
  validates :color, inclusion: {
             in: COLORS,
             message: "%{value} is not a valid color"
           }
  validates :sex, inclusion: {
    in: SEX,
    message: "%{value} is not a valid gender bro"
  }

  has_many(
    :rental_requests
    :class_name => "DragonRentalRequest",
    :foreign_key => :dragon_id,
    :primary_key => :id
  )
end