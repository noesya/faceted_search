# == Schema Information
#
# Table name: kinds
#
#  id         :integer          not null, primary key
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Kind < ApplicationRecord
  has_and_belongs_to_many :items

  def to_s
    "#{title}"
  end
end
