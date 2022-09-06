class User < ApplicationRecord
  validates :name, :github_url, presence: true

  def self.search_all_fields(query)
    results = where('name LIKE :search
                    OR nickname LIKE :search
                    OR organization LIKE :search
                    OR location LIKE :search',
                    search: "%#{query}%")
              .order(:name)
    
    results.any? ? results : "No matches found"
  end
end
