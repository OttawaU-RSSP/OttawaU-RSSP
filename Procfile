web: bundle exec unicorn -p $PORT -E $RACK_ENV -c config/unicorn.rb
resque: env TERM_CHILD=1 RESQUE_TERM_TIMEOUT=7 COUNT=3 bundle exec rake resque:workers QUEUE='real_time, default'
exporter: env TERM_CHILD=1 RESQUE_TERM_TIMEOUT=7 COUNT=3 bundle exec rake resque:workers QUEUE='exports'
