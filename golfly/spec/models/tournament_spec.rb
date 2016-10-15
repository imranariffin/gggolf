require 'rails_helper'

RSpec.describe Tournament, type: :model do
  it 'should exist as a model' do
    expect(Tournament.exists?).to be(true)
  end
end
