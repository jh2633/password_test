require 'sinatra'
class Password
  MIN_LENGTH = 10

  def initialize(password_string)
    @password = password_string
    @criteria = []

  end

  def attributes
    uppercase(@password)
    lowercase(@password)
    integer(@password)
    special(@password)
    @criteria
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
  def uppercase(password)
    if password.match?(/[A-Z]/)
      @criteria << :uppercase
    end
  end

  def lowercase(password)
    if password.match?(/[a-z]/)
      @criteria << :lowercase
      end
  end

  def integer(password)
    if password.match?(/[0-9]/)
      @criteria << :integer
    end
  end

  def special(password)
    if  password.match?(/\W/)
      @criteria << :special_character
    end
  end

  def no_repetition(password)

  end
  def min_length(password)
    password.length >= MIN_LENGTH
  end

end
