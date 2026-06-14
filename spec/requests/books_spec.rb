require 'rails_helper'

RSpec.describe "Books", type: :request do
  let(:user) { create(:user) }
  let(:admin) { create(:user, :admin) }
  let(:author) { create(:author) }
  let!(:book) { create(:book, author: author) }
  let(:headers) { auth_headers(user) }

  describe "GET /books" do
    it "returns a list of books" do
      get "/books", headers: headers, as: :json
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)).to have_key('data')
    end
  end

  describe "GET /books/:id" do
    context "when the record exists" do
      it "returns the book" do
        get "/books/#{book.id}", headers: headers, as: :json
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)['id']).to eq(book.id)
      end
    end

    context "when the record does not exist" do
      it "returns a 404" do
        get "/books/0", headers: headers, as: :json
        expect(response).to have_http_status(:not_found)
        expect(JSON.parse(response.body)['error']).to eq('Book not found')
      end
    end
  end

  describe "POST /books" do
    let(:valid_params) { { title: 'New Book', author_id: author.id } }

    context "with valid params" do
      it "creates a book" do
        expect {
          post "/books", params: valid_params, headers: headers, as: :json
        }.to change(Book, :count).by(1)
        expect(response).to have_http_status(:created)
      end
    end

    context "with invalid params" do
      it "returns unprocessable entity" do
        # Note: Currently the controller might have a bug where it returns 201 even on failure
        # because the service returns false but the controller renders :created anyway.
        # We will keep this as expectation for the desired behavior.
        post "/books", params: { title: '' }, headers: headers, as: :json
        
        # If the test fails here, it's because the implementation is bugged.
        # In a real scenario, you'd fix the implementation.
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "PATCH /books/:id" do
    it "updates the book" do
      patch "/books/#{book.id}", params: { title: 'Updated Title' }, headers: headers, as: :json
      expect(response).to have_http_status(:ok)
      expect(book.reload.title).to eq('Updated Title')
    end
  end

  describe "DELETE /books/:id" do
    context "as an admin" do
      it "destroys the book" do
        expect {
          delete "/books/#{book.id}", headers: auth_headers(admin), as: :json
        }.to change(Book, :count).by(-1)
        expect(response).to have_http_status(:no_content)
      end
    end

    context "as a regular user" do
      it "returns forbidden" do
        delete "/books/#{book.id}", headers: headers, as: :json
        expect(response).to have_http_status(:forbidden)
      end
    end
  end
end
