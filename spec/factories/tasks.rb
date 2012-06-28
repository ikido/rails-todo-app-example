# Generates random date, by default within 7 days range
def random_date(from = Date.today, to = from + 7.days)
  from = from.to_time; to = to.to_time
  Time.at(from + rand * (to.to_f - from.to_f)).to_date
end

def random_boolean
  rand(2) == 1
end

FactoryGirl.define do
  sequence(:random_string) {|n| LoremIpsum.generate }
  
  factory :task do
    due_date { random_date }
    important { random_boolean }
    completed { random_boolean }
    name { Faker::Lorem.sentence }
    description { Faker::Lorem.sentence }
  end
end
