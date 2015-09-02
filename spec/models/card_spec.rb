require 'rails_helper'

RSpec.describe Card, type: :model do
  before { @card = FactoryGirl.build(:card) }
  subject { @card }

  it { should belong_to :user }
  it { should have_many :labels }

  it { should validate_presence_of :side_a }
  it { should validate_presence_of :side_b }
end
