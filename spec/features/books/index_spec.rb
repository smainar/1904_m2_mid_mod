require "rails_helper"

RSpec.describe "Book Index Page", type: :feature do
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

    it "I see each book in the system including all the book's info" do
      visit "/books"

      within "#book-#{@book_1.id}" do
        expect(page).to have_content("Title: #{@book_1.title}")
        expect(page).to have_content("Pages: #{@book_1.pages}")
        expect(page).to have_content("Publication Year: #{@book_1.publication_year}")
        expect(page).to have_content("Author: #{@book_1.authors.name}")
      end

      within "#book-#{@book_2.id}" do
        expect(page).to have_content("Title: #{@book_2.title}")
        expect(page).to have_content("Pages: #{@book_2.pages}")
        expect(page).to have_content("Publication Year: #{@book_2.publication_year}")
        expect(page).to have_content("Author: #{@book_2.authors.name}")
      end

      within "#book-#{@book_3.id}" do
        expect(page).to have_content("Title: #{@book_3.title}")
        expect(page).to have_content("Pages: #{@book_3.pages}")
        expect(page).to have_content("Publication Year: #{@book_3.publication_year}")
        expect(page).to have_content("Author: #{@book_3.authors.name}")
      end
    end

    describe "I see each author's name is a link" do
      it "When I click the link, I am taken to an Author Show Page" do
        visit "/books"

        within "#book-#{@book_1.id}" do
          expect(page).to have_link(@author_1.name)
          click_link(@author_1.name)
        end
        
        expect(current_path).to eq("/authors/#{@author_1.id}")
      end
    end
  end
end
