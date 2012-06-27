# encoding: utf-8

Допустим /^сейчас дата "(.*?)"$/ do |date|
  t = Time.strptime(date, "%d.%m.%y")
  Timecop.travel(t)
end

Допустим /^в базе есть задачи:$/ do |table|
  table.hashes.each do |t|
    Task.create(
      due_date: t["дата"],
      important: t["важно"],
      completed: t["выполнено"],
      name: t["название"],
      description: t["описание"]
    )
  end
end

Если /^я захожу по адресу "(.*?)"$/ do |path|
  visit path
end

То /^вижу список задач которые есть в базе:$/ do |table|
  table.hashes.each do |t|
    page.should have_content text
  end
end