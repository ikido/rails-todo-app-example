# encoding: utf-8

require 'spec_helper'

describe "tasks/index.html.haml" do
  before :all do
    @calendar_date = Date.today
    @tasks = []
    5.times { |n| @tasks << FactoryGirl.build_stubbed(:task, :due_date => Date.today) }
    5.times { |n| @tasks << FactoryGirl.build_stubbed(:task, :due_date => Date.tomorrow) }
    
    assign :tasks, @tasks
    assign :calendar_date, @calendar_date
  end
  
  describe "calendar block" do
    
    it "displays current month name" do      
      render
      page.find('.calendar').should have_content Russian.strftime(@calendar_date, '%B')
    end
    
    it 'displays offset cells' do
      start_offset = @calendar_date.beginning_of_month.cwday - 1      
      end_offset = 7 - @calendar_date.end_of_month.cwday
      render

      if start_offset > 0
        page.find('.calendar table').first('tr').should have_selector('td.offset', :count => start_offset)
      else
        page.find('.calendar table').first('tr').should_not have_selector('td.offset')
      end
      
      if end_offset > 0
        page.find('.calendar table').all('tr').last.should have_selector('td.offset', :count => end_offset)
      else
        page.find('.calendar table').all('tr').last.should_not have_selector('td.offset')
      end  
    end
    
    it 'has 7 cells for each row' do
      render
      
      page.all('.calendar table tr').each do |row|
        row.should have_selector 'td', :count => 7
      end
    end
    
    it 'shows links to days wich have tasks' do
      assign :days_with_tasks, [Date.today, Date.tomorrow]
      
      render
      
      puts page.native
            
      page.find('.calendar').should have_link Date.today.strftime('%d')
      page.find('.calendar').should have_link Date.tomorrow.strftime('%d')
      page.find('.calendar').should_not have_link (Date.today + 2.days).strftime('%d')
    end
  end
  
  describe "tasks block" do

    it "displays message when there are no tasks" do
      # assign empty array, then put @tasks back
      assign :tasks, []
      render
      page.should have_selector 'div.empty_list_message'
      assign :tasks, @tasks
    end
    
    describe "when there are tasks" do

      it "displays name and title for each task" do
        render
        
        page.all('.tasks .task').each do |task| 
          task.should have_selector 'h3'
          task.should have_selector 'div.description'
        end
      end
    
      it "displays all task dates (and probably groups tasks by them)" do
        render
        
        dates = @tasks.map(&:due_date).uniq
        page.should have_selector '.tasks h2.date', :count => dates.size
      end
    end
  end
end