require 'rails_helper'

RSpec.describe ReservationDay, type: :model do
  describe "relationships" do
    it { should belong_to :trips }
  end

  describe "validations" do
    it { should validate_presence_of :date}
  end
end
