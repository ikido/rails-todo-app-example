# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :task do
    due_date "2012-06-27"
    important false
    completed false
    name "MyString"
    description "MyString"
  end
end
