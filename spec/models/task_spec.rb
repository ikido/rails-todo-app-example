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
  
  describe "::same_month_as" do
    it "has same_month_as scope" do
      Task.should respond_to(:same_month_as).with(1).arguments
    end
    
    it "includes tasks that are due in this month" do
      task = FactoryGirl.create :task, due_date: @current_date.end_of_month
      Task.same_month_as(@current_date).should include(task)
    end

    it "excludes tasks with past due dates" do
      # Time travel to past to create task
      past_date = @current_date.beginning_of_month - 1.day
      Timecop.travel past_date
      task = FactoryGirl.create :task, due_date: past_date
      Timecop.travel @current_date
      
      Task.same_month_as(@current_date).should_not include task
    end
    
    it "excludes tasks with due dates not within same month" do
      task = FactoryGirl.create :task, due_date: (@current_date.end_of_month + 1.day)
      Task.same_month_as(@current_date).should_not include task
    end
  end
end