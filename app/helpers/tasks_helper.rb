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
  
  def tasks_filter_link_to_attribute(attribute, value, link_text)
    attribute_is_set = instance_variable_get("@#{attribute.to_s}")
    path = tasks_path params.merge(attribute.to_sym => value)
    link_to_unless (attribute_is_set == value), link_text, path
  end
end