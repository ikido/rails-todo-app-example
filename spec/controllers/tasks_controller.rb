# encoding: utf-8

require 'spec_helper'

describe TasksController do 
  describe "GET index" do
    it "renders tasks index" do
      Task.should_recieve(:recent)
      Task.should_recieve(:reorder).with('due_date ASC')
      get :index
    end
  end
end