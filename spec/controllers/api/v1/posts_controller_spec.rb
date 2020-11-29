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
    it "should return a list of all the posts" do
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

  describe "POST#create" do
    context "when a request correct params is made" do
      let!(:good_post_data) { { post: {body: "yay"}, user_id: user1.id} }

      it "adds the post to the database" do 
        sign_in user1
        previous_count = Post.count

        post :create, params: good_post_data

        new_count = Post.count

        expect(new_count).to eq previous_count + 1
      end

      it "returns the new post object as json" do
        sign_in user1
        post :create, params: good_post_data

        returned_json = JSON.parse(response.body)

        expect(response.status).to eq 200
        expect(response.content_type).to eq("application/json")
        expect(returned_json).to be_kind_of(Hash)
        expect(returned_json).to_not be_kind_of(Array)
        expect(returned_json["body"]).to eq "yay"
      end
    end

    context "when parameters are not filled out but user is signed in" do
      let!(:bad_post_data) { { post: {body: ""} } }

      it "should not should not save to the database" do
        sign_in user1
        previous_count = Post.count

        post :create, params: bad_post_data

        new_count = Post.count

        expect(new_count).to eq previous_count
      end

      it "does not successfully create a post object" do
        sign_in user1
        post :create, params: bad_post_data

        returned_response = JSON.parse(response.body)
  
        expect(returned_response["errors"]["body"][0]).to eq "can't be blank"
      end
    end
    
    context "when the parameters are correct but user is not signed it" do
      let!(:bad_post_data) { { post: {body: "yay"} } }

      it "should not should not save to the database" do
        previous_count = Post.count

        post :create, params: bad_post_data

        new_count = Post.count

        expect(new_count).to eq previous_count
      end

      it "we are redirected to the sign in page" do
        post :create, params: bad_post_data
        
        response_body = response.body
        expect(response.status).to eq 302 
        expect(response_body).to eq "<html><body>You are being <a href=\"http://test.host/users/sign_in\">redirected</a>.</body></html>"
      end
    end
  end


end