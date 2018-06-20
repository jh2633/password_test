require 'sinatra'
class Password
  MIN_LENGTH = 10

  def initialize(password_string, rules)
    @password = password_string
    @rules = rules
  end


  def strength
    if min_length(@password)
      if no_repetition(@password)
        'strong'
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
    password.match?(/'(.)\1{2,}'/)
  end
  
  def min_length(password)
    password.length >= MIN_LENGTH
  end

end
