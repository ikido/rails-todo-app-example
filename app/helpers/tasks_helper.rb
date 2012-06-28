module TasksHelper
  def get_task_class(task)
    classes = ['task']
    classes << 'completed' if task.completed?
    classes << 'important' if task.important?
    
    classes.join(' ')
  end
  
  def get_calendar_day_class(day)
    classes = [day.to_s]
    classes << 'weekend' if [6,7].include?(day.cwday)
    
    classes.join(' ')
  end
end