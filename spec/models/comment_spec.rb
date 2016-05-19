require 'rails_helper'

RSpec.describe Comment, type: :model do
  # let(:post) {  Post.create!(title:"New Post Title", body:"New Post Body") }
  let(:topic) { Topic.create!(name: RandomData.random_sentence, description: RandomData.random_paragraph)}
  let(:user) { User.create!(name: "Bloccit User", email: "user@bloccit.com", password: "helloworld")}
  let(:post) { topic.posts.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph, user: user)}
  let(:post_comment) { Comment.create(body:"Post Comment Body", commentable:post, user:user) }
  let(:topic_comment) { Comment.create(body:"Topic Comment Body", commentable:topic, user:user) }


  it { is_expected.to belong_to(:commentable) }
  it { is_expected.to belong_to(:user) }
  it { is_expected.to validate_presence_of(:body) }
  it { is_expected.to validate_length_of(:body).is_at_least(5) }

  describe "attributes" do
    it "has a body attribute for post comment" do
      expect(post_comment).to have_attributes(body:"Post Comment Body", commentable_type: "Post")
    end
    it "has a body attribute for topic comment" do
      expect(topic_comment).to have_attributes(body:"Topic Comment Body", commentable_type: "Topic")
    end
  end
end
