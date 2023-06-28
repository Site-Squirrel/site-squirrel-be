require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'relationships' do
    it { should have_many :trips }
    it { should have_many(:reservation_days).through(:trips) }
  end

  describe 'validations' do
    it { should validate_presence_of :name}
    it { should validate_presence_of :email}
    it { should validate_presence_of :password_digest}
    it { should validate_presence_of :phone}
    it { should validate_uniqueness_of :email}
    it { should validate_uniqueness_of :phone}
  end
end