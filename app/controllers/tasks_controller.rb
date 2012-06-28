class TasksController < InheritedResources::Base
  def index
    @calendar_date = params[:date].blank? ? Date.today : Date.parse(params[:date])
    
    @tasks = Task.where(due_date: @calendar_date)
    @days_with_tasks = Task.same_month_as(@calendar_date).group(:due_date).map(&:due_date)
    
    index!
  end
end
