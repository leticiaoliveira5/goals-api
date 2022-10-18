FactoryBot.define do
  factory :goal, class: Goal do
    user
    title { 'Test Title' }
    description { 'Test Description' }
    deadline { 1.year.from_now }
  end
end
