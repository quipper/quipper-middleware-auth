require 'spec_helper'

describe Quipper::Middleware::Auth do
  it 'should have a version number' do
    Quipper::Middleware::Auth::VERSION.should_not be_nil
  end

  it 'should do something useful' do
    false.should be_true
  end
end
