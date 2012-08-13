# College Outside
A blog for people who like going outside

## Setup staging

    heroku create collegeoutside-staging -r staging
    heroku config:add RACK_ENV=staging RAILS_ENV=staging --remote staging
    git push staging master
    heroku run rake db:setup
    heroku addons:add sendgrid:starter
    heroku run console
    # create a chief
    heroku config:add AWS_ACCESS_KEY_ID=xxx AWS_SECRET_ACCESS_KEY=yyy
    heroku addons:add sendgrid:starter
