class TasksController < InheritedResources::Base
  def index
    @calendar_date = Date.today    
    @days_with_tasks = Task.where(:due_date => @calendar_date.beginning_of_month..@calendar_date.end_of_month).
      group(:due_date).
      map(&:due_date)
    
    index!
  end
protected
  def collection
    @tasks ||= end_of_association_chain.recent.reorder('due_date ASC')
  end
end