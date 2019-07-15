require "rails_helper"

RSpec.describe "Author Show Page", type: :feature do
  describe "As a user" do
    before(:each) do
      @book_1 = Book.create!(title: "Book 1", publication_year: 1999, pages: 100)
      @book_2 = Book.create!(title: "Book 2", publication_year: 2000, pages: 110)
      @book_3 = Book.create!(title: "Book 3", publication_year: 2001, pages: 120)

      @author_1 = @book_1.authors.create!(name: "Author 1")
      @author_2 = @book_1.authors.create!(name: "Author 2")
      @author_3 = @book_2.authors.create!(name: "Author 3")
      @author_4 = @book_3.authors.create!(name: "Author 4")
    end

    it "I see the author with that id including the author's info" do
      visit "/books"

      within "#book-#{@book_1.id}" do
        click_link(@author_1.name)
      end

      expect(current_path).to eq("/authors/#{@author_1.id}")
      expect(page).to have_content("Name: #{@author_1.name}")
      expect(page).to have_content("Book: #{@book_1.title}")
      expect(page).to have_content("Average Number of Pages: #{@author_1.average_pages}")
    end
  end
end
