# frozen_string_literal: true

require "spec_helper"

describe SocioDemographicAuthorizationHandler do
  subject do
    described_class.new(
      user: user,
      scope_id: scope_id,
      gender: gender,
      age: age
    )
  end

  let(:user) { create(:user) }

  let(:organization) { user.organization }
  let!(:scopes) { create_list(:scope, 9, organization: organization) }

  let(:scope_id) { organization.scopes.first.id }
  let(:gender) { "man" }
  let(:age) { "16-25" }

  context "when the information is valid" do
    it "is valid" do
      expect(subject).to be_valid
    end
  end

  context "when scope_id is not an integer" do
    let(:scope_id) { "fakedata" }

    it "is not valid" do
      expect(subject).not_to be_valid
    end
  end

  context "when scope_id doesn't refer to an valid scope" do
    let(:scope_id) { -1 }

    it "is not valid" do
      expect(subject).not_to be_valid
    end
  end

  context "when gender is not in list" do
    let(:gender) { "fakedata" }

    it "is not valid" do
      expect(subject).not_to be_valid
      expect(subject.errors[:gender]).to include("is not included in the list")
    end
  end

  context "when age is not in list" do
    let(:age) { "fakedata" }

    it "is not valid" do
      expect(subject).not_to be_valid
      expect(subject.errors[:age]).to include("is not included in the list")
    end
  end

  context "when one field is empty" do
    let(:scope_id) { nil }

    it "is valid" do
      expect(subject).to be_valid
    end
  end
end
