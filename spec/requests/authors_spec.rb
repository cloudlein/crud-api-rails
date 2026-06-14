require 'rails_helper'

RSpec.describe "Authors", type: :request do
  let(:user) { create(:user) }
  let(:admin) { create(:user, :admin) }
  let!(:author) { create(:author) }
  let(:headers) { auth_headers(user) }

  describe "GET /authors" do
    it "returns a list of authors" do
      get "/authors", headers: headers, as: :json
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)).to have_key('data')
    end
  end

  describe "GET /authors/:id" do
    it "returns the author" do
      get "/authors/#{author.id}", headers: headers, as: :json
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['id']).to eq(author.id)
    end
  end

  describe "POST /authors" do
    let(:valid_params) { { first_name: 'John', last_name: 'Doe' } }

    it "creates an author" do
      expect {
        post "/authors", params: valid_params, headers: headers, as: :json
      }.to change(Author, :count).by(1)
      expect(response).to have_http_status(:created)
    end
  end

  describe "GET /authors/:author_id/books" do
    let!(:books) { create_list(:book, 3, author: author) }

    it "returns books belonging to the author" do
      get "/authors/#{author.id}/books", headers: headers, as: :json
      expect(response).to have_http_status(:ok)
      
      json_response = JSON.parse(response.body)
      expect(json_response['data'].length).to eq(3)
    end
  end

  describe "DELETE /authors/:id" do
    context "as admin" do
      it "deletes the author" do
        expect {
          delete "/authors/#{author.id}", headers: auth_headers(admin), as: :json
        }.to change(Author, :count).by(-1)
        expect(response).to have_http_status(:no_content)
      end
    end
  end
end
