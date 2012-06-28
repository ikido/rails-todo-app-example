# encoding: utf-8

require 'spec_helper'

describe TasksController do 
  describe "GET index" do
    it "renders tasks index with current date as default" do
      today = Date.parse('27.06.2012')
      Timecop.travel today
      Task.should_recieve(:where).with(due_date: today)
      get :index
    end
    
    it "gets tasks for same month as current date" do
      today = Date.parse('27.06.2012')
      Timecop.travel today
      Task.should_recieve(:same_month_as).with(today)
      get :index
    end
    
    it "allows to view tasks for desired date using 'date' param" do
      date = '2012-06-30'
      Date.should_recieve(:parse).with('2012-06-30')
      get :index, :date => date
    end
  end
end