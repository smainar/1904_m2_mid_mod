require "rails_helper"

RSpec.describe Book, type: :model do
  describe "validations" do
    it { should validate_presence_of :title }
    it { should validate_presence_of :pages }
    it { should validate_presence_of :publication_year }
  end

  describe "relationships" do
    it { should have_many :book_authors }
    it { should have_many(:authors).through(:book_authors) }
  end

  describe "class methods" do
    before(:each) do
      @book_1 = Book.create!(title: "Book 1", publication_year: 1999, pages: 100)
      @book_2 = Book.create!(title: "Book 2", publication_year: 2000, pages: 110)
      @book_3 = Book.create!(title: "Book 3", publication_year: 2001, pages: 120)

      @author_1 = @book_1.authors.create!(name: "Author 1")
      @author_2 = @book_1.authors.create!(name: "Author 2")
      @author_3 = @book_2.authors.create!(name: "Author 3")
      @author_4 = @book_3.authors.create!(name: "Author 4")
    end

    describe "::average_pages" do
      it "returns the average number of pages for all of a particular author's books" do
        expect(@author_1.average_pages).to eq(100)
      end
    end
  end
end
