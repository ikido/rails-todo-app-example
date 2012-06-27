# encoding: utf-8
Допустим /^в базе есть задачи:$/ do |table|
  table.hashes.each do |t|
    FactoryGirl.create(
      :task,
      due_date: t["дата"],
      important: t["важно"],
      completed: t["выполнено"],
      name: t["название"],
      description: t["описание"]
    )
  end
end

То /^я вижу следующие задачи:$/ do |table|
  table.raw.flatten.each do |text|
    page.should have_content text
  end
end

То /^не вижу следующие задачи:$/ do |table|
  table.raw.flatten.each do |text|
    page.should_not have_content text
  end
end