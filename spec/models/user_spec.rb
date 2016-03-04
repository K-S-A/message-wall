require 'rails_helper'

RSpec.describe User, :model do
  it { expect(subject).to have_many(:messages) }
end
