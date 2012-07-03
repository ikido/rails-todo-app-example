# encoding: utf-8

require 'spec_helper'

describe "tasks/new.html.haml" do
  before(:all) do
    assign :task, FactoryGirl.build(:task, due_date: Date.today)
  end
  
  it "has link to go back" do
    render
    
    page.should have_link 'Вернуться назад'
  end
  
  it 'renders form partial' do
    render
    rendered.should render_template(:partial => '_form')
  end
end