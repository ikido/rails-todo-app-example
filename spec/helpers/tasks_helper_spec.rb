require "spec_helper"

describe TasksHelper do
  describe "#get_task_class" do
    it "return class which only contains 'task' if task is not important or completed" do
      task = FactoryGirl.create(:task, :completed => false, :important => false)
      helper.get_task_class(task).should eql "task"
    end
    
    it "return class which contains 'completed' if task is completed" do
      task = FactoryGirl.create(:task, :completed => true)
      helper.get_task_class(task).should include "completed"
    end
    
    it "return class which contains 'important' if task is important" do
      task = FactoryGirl.create(:task, :important => true)
      helper.get_task_class(task).should include "important"
    end
  end
  
  describe "#get_calendar_day_class" do
    
    it "returns day date by default" do
      work_day = Date.parse('01.06.2012')
      helper.get_calendar_day_class(work_day).should eql work_day.to_s
    end
    
    
    it "contains 'weekend' if it's sunday or saturday" do
      weekend_days = [Date.parse('02.06.2012'), Date.parse('03.06.2012')]
      weekend_days.each do |day|
        helper.get_calendar_day_class(day).should include 'weekend'
      end
    end
  end
end