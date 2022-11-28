class Student < ApplicationRecord
  belongs_to :instructor

  validates :name, presence: true
  validates :age,  numericality: { in: 18..120 }

end