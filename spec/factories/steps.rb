FactoryBot.define do
  factory :step do
    milestone
    title { 'Test Title' }
    description { 'Test Description' }
  end
end