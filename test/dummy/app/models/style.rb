class Style < ApplicationRecord
  has_many :items

  def to_s
    "#{title}"
  end
end
