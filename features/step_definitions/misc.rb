# encoding: utf-8

Допустим /^сейчас дата "(.*?)"$/ do |date|
  t = Time.strptime(date, "%d.%m.%Y")
  Timecop.travel(t)
end


Если /^я захожу по адресу "(.*?)"$/ do |path|
  visit path
end

То /^я вижу текст "(.*?)" в блоке "(.*?)"$/ do |text, block|
  page.find(block).should have_content text
end

То /^я вижу ссылки "(.*?)" в блоке "(.*?)"$/ do |links, block|
  links.split(', ').each do |link_text|
    page.find(block).should have_link link_text
  end
end

То /^я не вижу ссылку "(.*?)" в блоке "(.*?)"$/ do |link_text, block|
  page.find(block).should_not have_link link_text
end