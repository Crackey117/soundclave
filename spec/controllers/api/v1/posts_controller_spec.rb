require "rails_helper"
RSpec.describe Api::V1::PostsController, type: :controller do 
  let!(:post1) {Post.create(
    body: "Bring back live music!"
  )}
  let!(:post2) {Post.create(
    body: "Livestreams arent enough for me"
  )}
  
  describe "GET#index" do
    it "should return a list of all the locations" do
      get :index
      returned_json = JSON.parse(response.body)
      expect(response.status).to eq 200
      expect(response.content_type).to eq("application/json")
      expect(returned_json.length).to eq 2

      expect(returned_json[0]["body"]).to eq "Bring back live music!"
      expect(returned_json[1]["body"]).to eq "Livestreams arent enough for me"
    end
  end
end