FactoryBot.define do
  factory :goal, class: Goal do
    user
    title { 'Test Title' }
    description { 'Test Description' }
    deadline { 1.year.from_now }
  end

  factory :goal_with_milestones, class: Goal do
    user
    title { 'Test Title' }
    description { 'Test Description' }
    deadline { 1.year.from_now }

    milestones do
      Array.new(5) { association(:milestone) }
    end
  end
end
