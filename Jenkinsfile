stage 'Dev'
docker.image('stocksoftware/build:java-7.80.15_ruby-2.1.3').inside {
    checkout scm
    retry(8) {
        sh "rbenv exec bundle install --deployment"
    }
    sh "xvfb-run -a rbenv exec bundle exec buildr package"
}
stage 'Qa'
input message: "Does package look good?"
