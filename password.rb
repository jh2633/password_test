require 'sinatra'
class Password
  PWD_SCORE = {3 => 'ok', 4 => 'strong'}

  def initialize(password_string, rules = nil, requirement = nil)
    @password = password_string
    @optional_rules ||= {uppercase: /[A-Z]/, lowercase: /[a-z]/, integer: /[0-9]/, special: /\W/ }
    @required_rules ||= {min_characters: /.{10,}/}
  end


  def strength
    if meets_required_rules(@password)
      @points = 0
      meets_optional_rules
      PWD_SCORE.key?(@points) ? PWD_SCORE[@points] : 'weak'
    else
      'weak'
    end
  end

  private
  def meets_required_rules(password)
    @requirement.all? {|name, pattern| password.match?(pattern)}
  end

  def meets_optional_rules(password)
    @optional_rules.each do |name, pattern|
      if password.match?(pattern)
        @points += 1
      end
    end
  end

end
