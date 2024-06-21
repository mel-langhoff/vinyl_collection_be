class Artist < ApplicationRecord
  has_many :albums

  enum category: { solo: 0, group: 1 }

end