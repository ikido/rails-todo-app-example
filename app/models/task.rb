# encoding: utf-8

class Task < ActiveRecord::Base
  attr_accessible :completed, :description, :important, :name, :due_date
  
  validates_presence_of :due_date, :name
  validates_date :due_date, 
    on_or_after: :today, 
    on_or_after_message: "не может быть в прошлом",
    if: Proc.new { |t| t.due_date_changed? or t.new_record? }
end