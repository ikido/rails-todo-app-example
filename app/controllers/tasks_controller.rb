class TasksController < InheritedResources::Base
protected
  def collection
    @tasks ||= end_of_association_chain.recent.reorder('due_date ASC')
  end
end