require 'rails_helper'

 RSpec.describe Api::V1::CommentsController, type: :controller do
   let(:my_user) { create(:user) }
   let(:my_topic) { create(:topic) }
   let(:my_post) { create(:post, topic:my_topic, user:my_user) }
   let(:my_comment) { my_post.comments.create!(body: 'Comment Body', post: my_post, user: my_user) }

 # #20
   context "unauthenticated user" do
     it "GET index returns http success" do
       get :index
       expect(response).to have_http_status(:success)
     end

     it "GET show returns http success" do
       get :show, id: my_comment.id
       expect(response).to have_http_status(:success)
     end
   end

   context "unauthorized user" do
     before do
       controller.request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Token.encode_credentials(my_user.auth_token)
     end

 # #21
     it "GET index returns http success" do
       get :index
       expect(response).to have_http_status(:success)
     end

     it "GET show returns http success" do
       get :show, id: my_comment.id
       expect(response).to have_http_status(:success)
     end
   end
 end
