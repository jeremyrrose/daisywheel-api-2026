class Section < ApplicationRecord
    has_many :articles
    has_many :features
    attribute :article_list
end
