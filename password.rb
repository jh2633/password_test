require 'sinatra'
class Password
  MIN_LENGTH = 10
  PWD_SCORE = {3 => 'ok', 4 => 'strong'}

  def initialize(password_string, rules = nil, requirement = nil)
    @password = password_string
    @rules ||= {uppercase: /[A-Z]/, lowercase: /[a-z]/, integer: /[0-9]/, special: /\W/ }
    @requirement ||= {min_characters: /.{10,}/}
  end


  def strength
    if @requirement.all? {|name, pattern| @password.match?(pattern)}
      @points = 0
      @rules.each do |name, pattern|
        if @password.match?(pattern)
          @points += 1
        end
      end
      PWD_SCORE.key?(@points) ? PWD_SCORE[@points] : 'weak'
    else
      'weak'
    end
  end

end
