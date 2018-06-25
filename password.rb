class Password

  def initialize(password_string ,
                  rules: {uppercase: /[A-Z]/, lowercase: /[a-z]/, integer: /[0-9]/, special: /\W/ },
                  requirement: {min_characters: /.{10,}/},
                  score: {:ok => 3, :strong => 4})
    @password = password_string
    @optional_rules = rules
    @required_rules = requirement
    @password_score = score
  end


  def strength
    if meets_required_rules
      @points = 0
      meets_optional_rules
      password_scoring
    else
      "weak"
    end
  end

  private

  def password_scoring
    case @points
    when @password_score[:strong]
      "strong"
    when @password_score[:ok]..@password_score[:strong]
      "ok"
    else
      "weak"
    end
  end

  def meets_required_rules
    @required_rules.all? {|name, pattern| @password.match?(pattern)}

  end

  def meets_optional_rules
    @optional_rules.each do |name, pattern|
      @points += 1 if @password.match?(pattern)
    end
  end

end
