# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :task do
    date_due "2012-06-27"
    important false
    completed false
    title "MyString"
    description "MyString"
  end
end
