class UserMailer < ActionMailer::Base
  default from: 'notifications@example.com'
 
  def welcome_email(user)
    @user = user
    @url  = 'http://example.com/login'
    mail(to: "viveks1422@gmail.com", subject: 'Welcome to My Awesome Site')
  end
end