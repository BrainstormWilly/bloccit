require "rails_helper"

RSpec.describe Label, type: :model do

  let(:topic) { create(:topic) }
   let(:user) { create(:user) }
   let(:post) { create(:post) }
   let(:label1) { create(:label) }
   let(:label2) { create(:label) }

  it { is_expected.to have_many :labelings }
  it { is_expected.to have_many(:topics).through(:labelings) }
  it { is_expected.to have_many(:posts).through(:labelings) }

  describe "labelings" do
    it "allows the same label to be associated with a different topic and post" do
      topic.labels << label1
      post.labels << label1
      topic_label = topic.labels[0]
      post_label = post.labels[0]
      expect(topic_label).to eql(post_label)
    end
  end

  describe ".update_labels" do
    it "takes a comma delimited string and returns an array of Labels" do
        puts "#{label1.name}, #{label2.name}"
        labels = "#{label1.name}, #{label2.name}"
        labels_as_a = [label1, label2]
        expect(Label.update_labels(labels)).to eq(labels_as_a)
      end
  end

end
