require File.dirname(__FILE__) + '/../spec_helper'

describe <%= model %>  do
  
  before(:each) do
    @<%= item %> = Factory.build(:<%= item %>)
  end

  it "debe ser valido" do
    @<%= item %>.should be_valid
  end
  
end
