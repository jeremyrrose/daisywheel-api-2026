class Article < ApplicationRecord
    belongs_to :author, optional: true
    belongs_to :section, optional: true
    has_one_attached :image
    attribute :image_url, :string
    attribute :section_title, :string
    attribute :publication_date, :string
    attribute :author
end
