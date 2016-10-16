require 'rails_helper'

RSpec.describe ActiveRecord::Base, type: :model do
  it 'should pass a sanity test' do
    expect(1 == 1).to be(true)
  end
end
