FactoryBot.define do
  factory :milestone do
    goal
    title { 'Test Title' }
    description { 'Test Description' }
  end
end