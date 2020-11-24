require "rails_helper"
RSpec.describe Api::V1::PostsController, type: :controller do 
  let!(:user1) {User.create(
    email: "blah@gmail.com", 
    first_name: "blah",
    last_name: "blah",
    password: "blahblah",
    username: "blah",
    role: "Fan"
  )}
  let!(:user2) {User.create(
    email: "davy.jones@thelocker.com", 
    first_name: "davy",
    last_name: "jones",
    password: "blahblahblah",
    username: "squidguy",
    role: "Fan"
  )}
  let!(:post1) {Post.create(
    body: "Bring back live music!",
    user: user1
  )}
  let!(:post2) {Post.create(
    body: "Livestreams arent enough for me",
    user: user2
  )}
  
  describe "GET#index" do
    it "should return a list of all the locations" do
      get :index
      returned_json = JSON.parse(response.body)
      expect(response.status).to eq 200
      expect(response.content_type).to eq("application/json")
      expect(returned_json.length).to eq 1 
      expect(returned_json["post_items"][0]["user"]["username"]).to eq "blah"
      expect(returned_json["post_items"][0]["body"]).to eq "Bring back live music!"
      expect(returned_json["post_items"][1]["user"]["username"]).to eq "squidguy"
      expect(returned_json["post_items"][1]["body"]).to eq "Livestreams arent enough for me"
    end
  end
end