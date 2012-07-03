# encoding: utf-8

require 'spec_helper'

describe "tasks/_form.html.haml" do  
  before(:each) do
    @task = mock_model(Task, id: 1, due_date: Date.parse('27.06.2012'))
    assign :task, @task
  end

  it 'displays form for task, with due_date, name, descrition, importance and completed state' do
    render

    page.should have_selector 'form#edit_task_1'
    page.should have_field 'Дата', :type => 'text'
    page.should have_field 'Название', :type => 'text'
    page.should have_field 'Описание', :type => 'text'
    page.should have_field 'Важно', :type => 'checkbox'
    page.should have_field 'Выполнено', :type => 'checkbox'
  end

  it 'displays due date in russian format' do 
  
    render
    page.should have_field 'Дата', :with => '27.06.2012'
  end
end