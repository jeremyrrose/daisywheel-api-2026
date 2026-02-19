class Feature < ApplicationRecord
  belongs_to :section, optional: true
  belongs_to :article
end
