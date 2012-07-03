# encoding: utf-8

Допустим /^сейчас дата "(.*?)"$/ do |date|
  t = Time.strptime(date, "%d.%m.%Y")
  Timecop.travel(t)
end


Если /^я захожу по адресу "(.*?)"$/ do |path|
  visit path
end

То /^я вижу текст "(.*?)"$/ do |text|
  page.should have_content text
end

То /^я вижу ссылки "(.*?)"$/ do |links|
  links.split(', ').each do |link_text|
    page.should have_link link_text
  end
end

То /^я не вижу ссылку "(.*?)"$/ do |link_text|
  page.should_not have_link link_text
end

То /^я вижу ссылку "(.*?)"$/ do |link_text|
  page.should have_link link_text
end

Если /^я нажимаю на ссылку "(.*?)"$/ do |link_text|
  page.click_link link_text
end

Если /^я нажимаю на первую ссылку "(.*?)"$/ do |link_text|
  page.first('a', text: link_text).click
end

То /^я вижу поле "(.*?)" заполненное как "(.*?)"$/ do |field_name, field_value|
  page.should have_field field_name, with: field_value
end

Если /^я заполняю поле "(.*?)" как "(.*?)"$/ do |field_name, field_value|
  page.fill_in field_name, with: field_value
end

Если /^я нажимаю кнопку "(.*?)"$/ do |button_name|
  page.click_button button_name
end

Если /^я отмечаю чекбокс "(.*?)"$/ do |check_box_name|
  page.check check_box_name
end

Если /^я снимаю чекбокс "(.*?)"$/ do |check_box_name|
  page.uncheck check_box_name
end

То /^я вижу отмеченный чекбокс "(.*?)"$/ do |check_box_name|
  page.should have_checked_field check_box_name
end

То /^я вижу не отмеченный чекбокс "(.*?)"$/ do |check_box_name|
  page.should have_unchecked_field check_box_name
end