class Magazine < ApplicationRecord
    serialize :pages_order, coder: JSON
end
