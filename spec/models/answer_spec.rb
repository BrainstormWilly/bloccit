require 'rails_helper'

RSpec.describe Answer, type: :model do
  let( :question ) { Question.create!(title:"New Question Title", body:"New Question body") }
  let( :answer ) { Answer.create( question: question, body: "New Answer body") }

  describe "attributes" do
    it "has a body attribute" do
      expect( answer ).to have_attributes(body: "New Answer body")
    end
  end
end
