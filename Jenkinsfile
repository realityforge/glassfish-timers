stage 'Dev'
docker.image('stocksoftware/build:java-7.80.15_ruby-2.1.3').inside {
    checkout scm
    sh """
update_bundler() {
  if [ "\$1" = 'quiet' ]; then
    rbenv exec bundle install --deployment > /dev/null 2> /dev/null
  else
    rbenv exec bundle install --deployment
  fi
}

if [ -f Gemfile ]; then
  i="0"

  until (bundle check > /dev/null 2> /dev/null) || [ \$i -gt 10 ]; do
    echo "Bundle update. Attempt: \$i"
    update_bundler 'quiet'
    i=\$[\$i+1]
  done

  if !(bundle check > /dev/null 2> /dev/null); then
    echo "Last Bundle update attempt."
    update_bundler
  fi
fi
# xvfb-run -a
rbenv exec bundle exec buildr ci:commit
"""
/*
node {
  checkout scm
  sh "buildr clean package"
}
*/
}
stage 'Qa'
input message: "Does package look good?"
