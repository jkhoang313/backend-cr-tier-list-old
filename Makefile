reset_seed:
	rake db:drop RAILS_ENV=test
	rake db:create RAILS_ENV=test
	rake db:migrate RAILS_ENV=test
	rake db:seed RAILS_ENV=test

server:
	rake db:drop RAILS_ENV=test
	rake db:create RAILS_ENV=test
	rake db:migrate RAILS_ENV=test
	rake db:seed RAILS_ENV=test
	rails s -e test
