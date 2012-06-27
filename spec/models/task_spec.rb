# encoding: utf-8

require 'spec_helper'

describe Task do
  before(:all) do
    @current_date = Date.new(2012, 06, 27)
    Timecop.travel @current_date
  end
  
  it "is valid with valid attributes" do
    FactoryGirl.build(:task, due_date: Date.today.strftime("%d.%m.%Y")).should be_valid
  end
  
  it "is not valid with blank name" do
    FactoryGirl.build(:task, name: nil, due_date: "27.06.2012").should_not be_valid
  end
  
  it "is not valid without due date" do
    FactoryGirl.build(:task, due_date: nil).should_not be_valid
  end
  
  it "is not valid with due date in wrong format" do  
    FactoryGirl.build(:task, due_date: "06.27.2012").should_not be_valid
  end
  
  it "is not valid with due date in the past when creating task" do
    task = FactoryGirl.build(:task, due_date: (@current_date - 1.day).strftime("%d.%m.%Y")).should_not be_valid
  end  
  
  it "is not valid with due date in the past when updating due date" do
    task = FactoryGirl.create(:task, due_date: (@current_date + 1.day).strftime("%d.%m.%Y"))
    task.should be_valid
    
    task.due_date = @current_date - 1.day
    task.should_not be_valid
  end
  
  describe "::recent" do
    it "has recent scope" do
      Task.should respond_to(:recent)
    end
    
    it "includes tasks that are due in 7 days including today" do
      @task = FactoryGirl.create(:task, :due_date => (@current_date + 6.days).strftime("%d.%m.%Y"))
      Task.recent.should include(@task)
    end

    it "excludes tasks with past due dates" do
      # Time travel to yeasterday to create task
      Timecop.travel(@current_date - 1.day)
      @task = FactoryGirl.create(:task, :due_date => (@current_date - 1.day).strftime("%d.%m.%Y"))
      Timecop.travel(@current_date)
      
      Task.recent.should_not include(@task)      
    end
    
    it "excludes tasks with due dates not within next 6 days" do
      @task = FactoryGirl.create(:task, :due_date => (@current_date + 7.days).strftime("%d.%m.%Y"))
      Task.recent.should_not include(@task)
    end
  end
end