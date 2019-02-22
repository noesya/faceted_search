# == Schema Information
#
# Table name: products
#
#  id         :integer          not null, primary key
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Product < ApplicationRecord
  has_and_belongs_to_many :items

  def to_s
    "#{title}"
  end
end
