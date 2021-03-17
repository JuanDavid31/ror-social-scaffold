require 'rails_helper'

RSpec.describe User, type: :model do
  let(:juan) { User.new(name: 'Juan', email: 'johndoe1@sample.com', password: '12345678') }

  describe '#valid?' do
    it 'does validate all the user variables' do
      expect(User.new.valid?).to be false
    end

    it 'does validate the user name' do
      expect(juan.valid?).to be true
    end
  end
end
