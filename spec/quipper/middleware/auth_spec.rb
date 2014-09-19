require 'spec_helper'

describe Quipper::Middleware::Auth do
  it 'should have a version number' do
    expect(Quipper::Middleware::Auth::VERSION).not_to be_nil
  end
end
