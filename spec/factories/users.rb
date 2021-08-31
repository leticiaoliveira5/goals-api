FactoryBot.define do
  factory :user do
    username { 'testuser' }
    email { 'exampleuser@example.com' }
    password { '12345678' }
  end
end
