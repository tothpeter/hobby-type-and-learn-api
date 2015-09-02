FactoryGirl.define do
  factory :card do
    user
    side_a "side a"
    side_b "side b"
    proficiency_level 0
  end
end
