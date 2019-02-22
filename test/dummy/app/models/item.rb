# == Schema Information
#
# Table name: items
#
#  id         :integer          not null, primary key
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Item < ApplicationRecord
  has_and_belongs_to_many :kinds
  has_and_belongs_to_many :categories
  has_and_belongs_to_many :products

  def to_s
    "#{title}"
  end
end
