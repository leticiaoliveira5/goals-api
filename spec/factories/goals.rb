FactoryBot.define do
  factory :goal, class: Goal do
    title { 'Test Title' }
    description { 'Test Description' }
    deadline { 1.year.from_now }
  end

  factory :goal_with_milestones, class: Goal do
    title { 'Test Title' }
    description { 'Test Description' }
    deadline { 1.year.from_now }

    transient do
      milestones_count { 5 }
    end

    milestones do
      Array.new(milestones_count) { association(:milestone) }
    end
  end
end
