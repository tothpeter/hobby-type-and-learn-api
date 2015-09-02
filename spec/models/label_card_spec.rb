require 'rails_helper'

RSpec.describe LabelCard, type: :model do
  it { should belong_to :label }
  it { should belong_to :card }
end
