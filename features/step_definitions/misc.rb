# encoding: utf-8

Допустим /^сейчас дата "(.*?)"$/ do |date|
  t = Time.strptime(date, "%d.%m.%Y")
  Timecop.travel(t)
end


Если /^я захожу по адресу "(.*?)"$/ do |path|
  visit path
end