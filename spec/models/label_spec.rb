require 'rails_helper'

RSpec.describe Label, type: :model do
  before { @label = FactoryGirl.build(:label) }
  subject { @label }

  it { should belong_to :user }

  it { should validate_presence_of :title }
end
