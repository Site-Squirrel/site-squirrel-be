class DestroySerializer
  def initialize(message)
    @message = message
  end

  def destroyed_successfully
    {
      message: @message
    }
  end
end
