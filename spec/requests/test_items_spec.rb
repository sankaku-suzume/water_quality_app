require 'rails_helper'

RSpec.describe "TestItems", type: :request do
  let!(:test_items) { create_list(:test_item, 3) }
  describe "GET /test_items" do
    it "works! (now write some real specs)" do
      get test_items_path
      expect(response).to have_http_status(200)
    end
  end
end
