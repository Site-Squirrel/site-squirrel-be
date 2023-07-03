class ErrorSerializer
  def initialize(errors)
    @errors = errors
  end

  def invalid_request
    {
      errors: [
        {
          "status": '400',
          "title": 'Invalid Request',
          "detail": @errors
        }
      ]
    }
  end
end
