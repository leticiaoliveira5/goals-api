FactoryBot.define do
  factory :goal do
    title { 'Test Title' }
    description { 'Test Description' }
    deadline { 1.year.from_now }
  end
end