require 'spec_helper'

describe User do
  it { should have_many(:queue_items) }
  it { should have_many(:reviews) }
  it { should validate_presence_of(:full_name) }
  it { should validate_presence_of(:password) }
  it { should validate_presence_of(:email) }
  it { should validate_uniqueness_of(:email) }
  it { should have_many(:follower_relationships) }
  it { should have_many(:followee_relationships) }

  describe "#follows?" do
    it "returns true if user already follows another_user" do
      josh = Fabricate(:user, full_name: "Josh S", password: "josh", email: "josh@example.com")
      jason = Fabricate(:user, full_name: "Jason S", password: "jason", email: "jason@example.com")
      Fabricate(:following, follower_id: josh.id, followee_id: jason.id)
      expect(josh.follows?(jason)).to be_true
    end
    it "returns false if user does not already follow another user" do
      josh = Fabricate(:user, full_name: "Josh S", password: "josh", email: "josh@example.com")
      jason = Fabricate(:user, full_name: "Jason S", password: "jason", email: "jason@example.com")
      expect(josh.follows?(jason)).to be_false
    end
  end
end
