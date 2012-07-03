# encoding: utf-8

require 'spec_helper'

describe TasksController do
  before(:each) do
    @task = mock_model(Task)
    Task.stub_chain(:same_month_as, :group).and_return([@task])
  end
  
  describe "GET index" do
    it "renders tasks index with current date as default" do
      today = Date.parse('27.06.2012')
      Timecop.travel today
      
      Task.should_receive(:where).once.with(due_date: today)
      
      get :index
      assigns(:calendar_date).should eq(today)
    end
    
    it "gets tasks for same month as current date" do
      today = Date.parse('27.06.2012')
      Timecop.travel today
      
      Task.should_receive(:same_month_as).once.with(today)
      
      get :index
    end
    
    it "allows to view tasks for desired date using 'date' param" do
      date = '2012-06-30'
      parsed_date = Date.parse(date)
      
      Date.should_receive(:parse).with('2012-06-30').and_return(parsed_date)
      
      get :index, :date => date
      assigns(:calendar_date).should eq(parsed_date)
    end
  end
  
  describe "GET new" do
    it "assigns new task object" do
      new_task = Task.new
      Task.should_receive(:new).and_return(new_task)

      get :new
      assigns(:task).should eq(new_task)
    end
    
    it "populates date from 'date' param if present" do
      date = '2012-06-30'
      Task.should_receive(:new).with(due_date: date)
      get :new, :date => date
    end
  end
  
  describe "POST create" do
    before(:each) do
      Task.should_receive(:new).and_return(@task)
    end
    
    it 'sets success flash message on successfull create' do
      @task.should_receive(:save).and_return(true)
      
      post :create
      response.should redirect_to(tasks_path(:date => @task.due_date))
      flash[:notice].should eql I18n.t('tasks.flash.create.success')
    end
    
    it 'sets error flash message on failed create' do
      @task.should_receive(:save).and_return(false)
      
      post :create
      response.should render_template(:new)
      flash.now[:alert].should eql I18n.t('tasks.flash.create.error')
    end
  end
  
  describe "GET edit" do
    it "assigns task object from id" do
      task = mock_model(Task)
      Task.should_receive(:find).with("1").and_return(task)
      get :edit, :id => "1"
      assigns(:task).should eq(task)
    end
  end
  
  describe "POST update" do
    before(:each) do
      @task = mock_model(Task, id: 1)
      Task.should_receive(:find).with("1").and_return(@task)
    end
    
    it 'sets success flash message on successfull update' do
      @task.should_receive(:update_attributes).and_return(true)
      
      post :update, :id => 1
      response.should redirect_to(tasks_path(:date => @task.due_date))
      flash[:notice].should eql I18n.t('tasks.flash.update.success')
    end
    
    it 'sets error flash message on failed update' do
      @task.should_receive(:update_attributes).and_return(false)
      
      post :update, :id => 1
      response.should render_template(:edit)
      flash.now[:alert].should eql I18n.t('tasks.flash.update.error')
    end
  end
  
  describe "POST update" do
    before(:each) do
      @task = mock_model(Task, id: 1)
      Task.should_receive(:find).with("1").and_return(@task)
    end
    
    it 'sets success flash message on successfull update' do
      @task.should_receive(:update_attributes).and_return(true)
      
      post :update, :id => 1
      response.should redirect_to(tasks_path(:date => @task.due_date))
      flash[:notice].should eql I18n.t('tasks.flash.update.success')
    end
    
    it 'sets error flash message on failed update' do
      @task.should_receive(:update_attributes).and_return(false)
      
      post :update, :id => 1
      response.should render_template(:edit)
      flash.now[:alert].should eql I18n.t('tasks.flash.update.error')
    end
  end
  
  describe 'DELETE destroy' do
    before(:each) do
      @task = mock_model(Task, id: 1)
      Task.should_receive(:find).with("1").and_return(@task)
    end
    
    it 'sets success flash message on successfull destroy' do
      @task.should_receive(:destroy).and_return(true)
      
      delete :destroy, :id => 1
      response.should redirect_to(tasks_path(:date => @task.due_date))
      flash[:notice].should eql I18n.t('tasks.flash.destroy.success')
    end
    
    it 'sets error flash message on failed destroy' do
      @task.should_receive(:destroy).and_return(false)
      
      delete :destroy, :id => 1
      response.should redirect_to(tasks_path(:date => @task.due_date))
      flash.now[:alert].should eql I18n.t('tasks.flash.destroy.error')
    end
  end
end