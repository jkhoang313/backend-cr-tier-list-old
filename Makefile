test:
	@echo "Dropping backend-tier-list_test..."; \
	dropdb backend-tier-list_test --if-exists
	@echo "Creating backend-tier-list_test..."; \
	createdb backend-tier-list_test
	bundle exec rspec

refresh_e2e:
	@echo "Refreshing e2e seed file"; \
	pg_dump backend-tier-list_test > e2e-seed.dump

e2e:
	@echo "Dropping backend-tier-list_test..."; \
	dropdb backend-tier-list_test --if-exists
	@echo "Creating backend-tier-list_test..."; \
	createdb backend-tier-list_test
	psql backend-tier-list_test < e2e-seed.dump
	bundle exec rails s -e test

reset_seed:
	rake db:drop RAILS_ENV=test
	rake db:create RAILS_ENV=test
	rake db:migrate RAILS_ENV=test
	rake db:seed RAILS_ENV=test
