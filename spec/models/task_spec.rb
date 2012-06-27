# encoding: utf-8

require 'spec_helper'

describe Task do
  before(:all) do
    Timecop.travel(Time.new 2012, 06, 27)
  end
  
  it "is valid with valid attributes" do
    Task.new(name: "Тест", due_date: "27.06.2012").should be_valid
  end
  
  it "is not valid with blank name" do
    Task.new(due_date: "27.06.2012").should_not be_valid
  end
  
  it "is not valid without due date" do
    Task.new(name: "Тест").should_not be_valid
  end
  
  it "is not valid with due date in wrong format" do  
    Task.new(name: "Тест", due_date: "06.27.2012").should_not be_valid
  end
  
  it "is not valid with due date in the past when creating task" do
    Task.new(name: "Тест", due_date: "21-06-2012").should_not be_valid
  end  
  
  it "is not valid with due date in the past when updating due date" do
    task = Task.create(name: "Тест", due_date: "27-06-2012")
    task.should be_valid
    
    task.due_date = "21-06-2012"
    task.should_not be_valid
  end
  
  
end