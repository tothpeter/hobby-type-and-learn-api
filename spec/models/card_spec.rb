require 'rails_helper'

RSpec.describe Card, type: :model do
  include ActionDispatch::TestProcess

  before { @card = FactoryGirl.build(:card) }
  subject { @card }

  it { should belong_to :user }
  it { should have_many :labels }

  it { should validate_presence_of :side_a }
  it { should validate_presence_of :side_b }

  describe "#import" do
    it "imports .xls without any header specified" do
      file = fixture_file_upload('/files/without_header.xls', 'application/vnd.ms-excel')

      Card.import file, @card.user

      expect(@card.user.cards.count).to eq 2
      expect(@card.user.cards.first.side_a).to eq "aa"
    end

    it "imports .xlsx without any header specified" do
      file = fixture_file_upload('/files/without_header.xlsx', 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet')

      Card.import file, @card.user

      expect(@card.user.cards.count).to eq 2
      expect(@card.user.cards.first.side_a).to eq "aa"
    end

    it "imports .xls with header specified" do
      file = fixture_file_upload('/files/with_header.xls', 'application/vnd.ms-excel')

      Card.import file, @card.user

      expect(@card.user.cards.count).to eq 2
      expect(@card.user.cards.first.side_a).to eq "aa"
    end

    it "imports .xlsx with header specified" do
      file = fixture_file_upload('/files/with_header.xlsx', 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet')

      Card.import file, @card.user

      expect(@card.user.cards.count).to eq 2
      expect(@card.user.cards.first.side_a).to eq "aa"
    end
  end
end
