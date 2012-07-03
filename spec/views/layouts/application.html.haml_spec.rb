# encoding: utf-8

require 'spec_helper'

describe 'layouts/application' do
  it "renders flash notices" do
    flash[:notice] = "This is a notice!"
    render
    rendered.should have_content "This is a notice!"
  end
  
  it "renders flash errors" do
    flash[:error] = "This is an error!"
    render
    rendered.should have_content "This is an error!"
  end
end