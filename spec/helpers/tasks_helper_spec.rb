require "spec_helper"

describe TasksHelper do
  describe "#get_task_class" do
    it "return class which only contains 'task' if task is not important or completed" do
      task = FactoryGirl.create(:task)
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
end