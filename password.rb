require 'sinatra'
class Password
  MIN_LENGTH = 10
  PWD_SCORE = {3 => 'ok', 4 => 'strong'}

  def initialize(password_string, *rules)
    @password = password_string
    @rules = rules || {uppercase: /[A-Z]/, lowercase: /[a-z]/, integer: /[0-9]/, special: /\W/ }
  end


  def strength
    @points = 0
    @rules.each do |name, pattern|
      if @password.match?(pattern)
        @points += 1
      end
    end
    PWD_SCORE.key?(@points) ? PWD_SCORE[@points] : 'weak'

  end

  private
  # def uppercase(password)
  #   if password.match?(/[A-Z]/)
  #     @criteria << :uppercase
  #   end
  # end
  #
  # def lowercase(password)
  #   if password.match?(/[a-z]/)
  #     @criteria << :lowercase
  #     end
  # end
  #
  # def integer(password)
  #   if password.match?(/[0-9]/)
  #     @criteria << :integer
  #   end
  # end
  #
  # def special(password)
  #   if  password.match?(/\W/)
  #     @criteria << :special_character
  #   end
  # end

  def no_repetition(password)
    password.match?(/'(.)\1{2,}'/)
  end

  def min_length(password)
    password.length >= MIN_LENGTH
  end

end
