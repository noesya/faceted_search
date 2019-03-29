# == Schema Information
#
# Table name: categories
#
#  id         :integer          not null, primary key
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Category < ApplicationRecord
  include ActsAsTree

  has_and_belongs_to_many :items
  belongs_to  :parent,
              optional: true,
              class_name: 'Category'
  has_many    :children,
              class_name: 'Category',
              foreign_key: :parent_id

  def to_s
    "#{title}"
  end
end
