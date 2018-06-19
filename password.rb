require 'sinatra'
class Password
  MIN_LENGTH = 10

  def initialize(password_string)
    @password = password_string
  end

  def strength
    if min_length(@password)
      if no_repetition(@password)

      else
        'weak'
      end
    else
      'weak'
    end
  end

  private


  def no_repetition(password)

  end
  def min_length(password)
    password.length >= MIN_LENGTH
  end

end
