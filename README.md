Configuration
- The password class uses the match! method to return a boolean for evaluating a string to a regex pattern. This method was added in Ruby 2.4
- Capybara uses headless chrome as its javascript driver in this application's configuration. This is a cask package that would need to be installed if not already available on the machine, in addition to the Chrome browser.
brew cask install chromedriver

The two parts of the test to implement for this tests are below
- Implement a back-end service that will receive the password and return either "weak", "ok" or "strong";
- Implement a small front end application that calls the back-end service to measure the password and show the user the strength of their password as they are typing.

### Criteria for 'secure' password

It is important to first define what would constitute the three different levels of password strength laid out in this brief. For example, the OWASP documentation for password complexity says that 3 out of these 4 elements would need to be present:
- at least 1 uppercase character (A-Z)
- at least 1 lowercase character (a-z)
- at least 1 digit (0-9)
- at least 1 special character (punctuation) — do not forget to treat space as special characters too.

that is in addition to a minimum length requirement of 10 characters while not exceeding 120 characters.
On the other hand, there are many libraries that have went even further in terms of determining what qualifies as a 'strong' password. On a quick search one can find solutions such as Dropbox's zxcvbn (https://github.com/dropbox/zxcvbn) or the ruby gem StrongPassword (https://github.com/bdmac/strong_password), which utilizes an entropy algorithm to calculate password strength. For the purpose of this technical test and the sake of simplicity, I will use the four criteria from OWASP as measurement of password strength.

- Weak - The password meets less than three criteria
- OK - The password meets three criteria
- Strong - The password meets all four criteria
