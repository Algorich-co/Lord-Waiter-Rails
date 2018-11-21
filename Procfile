web: bundle exec puma -p $PORT 
rpush: bundle exec rpush start -e $RACK_ENV -f
web_rpush: bundle exec puma -p $PORT & bundle exec rpush start -e $RACK_ENV -f & wait -n