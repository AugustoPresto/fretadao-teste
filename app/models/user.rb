class User < ApplicationRecord
  validates :name, :github_url, presence: true
  validates :github_url, uniqueness: true
  has_one :bitlink, dependent: :destroy

  def self.search_all_fields(query)
    # Searches for query in all columns of the model
    results = where('name ILIKE :search
                    OR nickname ILIKE :search
                    OR github_url ILIKE :search
                    OR organization ILIKE :search
                    OR location ILIKE :search',
                    search: "%#{query}%")
              .order(:name)

    results.any? ? results : 'No matches found'
  end

  def update_gh_info_job
    UpdateGhInfoJob.perform_async(id)
  end
end
