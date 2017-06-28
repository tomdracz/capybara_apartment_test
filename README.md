# README
## Testing
* ```bundle install```
* modify config/database.yml as necessary
* Setup db and run rspec
    - ```bin/rails db:setup```
    - ```bin/rspec```
* Both non-js specs in ```test_spec.rb``` will pass, js specs will fail on second assertion

