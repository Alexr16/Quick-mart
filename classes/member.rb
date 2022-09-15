require 'securerandom'

class Member
  attr_accessor :status

  def initialize(status)
    @id = SecureRandom.uuid
    @status = status
  end
end
