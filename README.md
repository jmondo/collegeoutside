# College Outside
A blog for people who like going outside

## Setup staging

    heroku create collegeoutside-staging
    heroku config:add RACK_ENV=staging RAILS_ENV=staging --remote staging
    git push staging master
    heroku run rake db:setup
    heroku run console
    # create a chief
    # enter s3 creds
    heroku addons:add sendgrid:starter
