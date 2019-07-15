class Book < ApplicationRecord
  validates_presence_of :title,
                        :pages,
                        :publication_year

  has_many :book_authors
  has_many :authors, through: :book_authors
end
