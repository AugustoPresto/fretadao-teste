class User < ApplicationRecord
  validates :name, :github_url, presence: true
  validates :github_url, uniqueness: true

  def self.search_all_fields(query)
    results = where('name ILIKE :search
                    OR nickname ILIKE :search
                    OR organization ILIKE :search
                    OR location ILIKE :search',
                    search: "%#{query}%")
              .order(:name)
    
    results.any? ? results : "No matches found"
  end
end
