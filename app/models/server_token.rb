class ServerToken < ActiveRecord::Base
  attr_accessible :name, :token
  
  validates :name, :presence => true
  validates :token, :presence => true, :uniqueness => true
  
  before_create :generate_token
  
  private
  
  def generate_token
    self.token = SecureRandom.hex(32)
  end
end
