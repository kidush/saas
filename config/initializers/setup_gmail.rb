ActionMailer::Base.smtp_settings = {
    :user_name => 'app47264104@heroku.com',
    :password => '0querhu36786',
    :domain => 'saas-prova.herokuapp.com',
    :address => 'smtp.sendgrid.net',
    :port => 587,
    :authentication => :plain,
    :enable_starttls_auto => true
}