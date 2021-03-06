class TasksController < ApplicationController
  def index
    @calendar_date = params[:date].blank? ? Date.today : Date.parse(params[:date])
    
    @tasks = Task.where(due_date: @calendar_date)    
    @tasks = scope_collection_by_attribute(@tasks, :important)
    @tasks = scope_collection_by_attribute(@tasks, :completed)
    
    @days_with_tasks = Task.same_month_as(@calendar_date).group(:due_date).map(&:due_date)
  end
  
  def new
    @task = Task.new(due_date: params[:date])    
  end
  
  def create
    @task = Task.new(params[:task])
    if @task.save
      redirect_to tasks_path(date: @task.due_date), notice: I18n.t('tasks.flash.create.success')
    else
      flash.now[:alert] = I18n.t('tasks.flash.create.error')
      render :new
    end
  end
  
  def edit
    @task = Task.find(params[:id])
  end
  
  def update
    @task = Task.find(params[:id])
    if @task.update_attributes(params[:task])
      redirect_to tasks_path(date: @task.due_date), notice: I18n.t('tasks.flash.update.success')
    else
      flash.now[:alert] = I18n.t('tasks.flash.update.error')
      render :edit
    end
  end
  
  def destroy
    @task = Task.find(params[:id])
    if @task.destroy
      redirect_to tasks_path(date: @task.due_date), notice: I18n.t('tasks.flash.destroy.success')
    else
      redirect_to tasks_path(date: @task.due_date), alert: I18n.t('tasks.flash.destroy.error')
    end
  end
  
  def scope_collection_by_attribute(collection, attribute)
    attribute = attribute.to_sym
    
    if %w(true false).include?(params[attribute])
      instance_variable_set "@#{attribute}", params[attribute] == 'true' ? true : false
      collection = collection.where(attribute => instance_variable_get("@#{attribute}"))
    end
    
    collection
  end
end
