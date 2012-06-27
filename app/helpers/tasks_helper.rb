module TasksHelper
  def get_task_class(task)
    classes = ['task']
    classes << 'completed' if task.completed?
    classes << 'important' if task.important?
    
    classes.join(' ')
  end
end