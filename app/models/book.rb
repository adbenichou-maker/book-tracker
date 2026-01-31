class Book < ApplicationRecord
  validates :title, :author, presence: true
  validates :publication_year, comparison: { less_than_or_equal_to: 2026 }
  validates :status, inclusion: { in: ["Pending", "Read"] }
end
