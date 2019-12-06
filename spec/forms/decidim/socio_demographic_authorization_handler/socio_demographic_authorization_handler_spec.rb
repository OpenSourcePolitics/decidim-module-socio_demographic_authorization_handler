# frozen_string_literal: true

require "spec_helper"

describe SocioDemographicAuthorizationHandler do
  subject do
    described_class.new(
      user: user,
      scope: scope,
      gender: gender,
      age: age
    )
  end

  let(:user) { create(:user) }

  let(:organization) { user.organization }
  let!(:scopes) { create_list(:scope, 9, organization: organization) }

  let(:scope) { organization.scopes.first.code.downcase }
  let(:gender) { "man" }
  let(:age) { "16-25" }

  context "when the information is valid" do
    before do
      organization.scopes.each { |scope| described_class::SCOPES << scope.code.downcase }
    end

    it "is valid" do
      expect(subject).to be_valid
    end
  end

  context "when scope is invalid" do
    let(:scope) { "fakedata" }

    it "is not valid" do
      expect(subject).not_to be_valid
      expect(subject.errors[:scope]).to include("is not included in the list")
    end
  end

  context "when gender is invalid" do
    let(:gender) { "fakedata" }

    it "is not valid" do
      expect(subject).not_to be_valid
      expect(subject.errors[:gender]).to include("is not included in the list")
    end
  end

  context "when age is invalid" do
    let(:age) { "fakedata" }

    it "is not valid" do
      expect(subject).not_to be_valid
      expect(subject.errors[:age]).to include("is not included in the list")
    end
  end
end
