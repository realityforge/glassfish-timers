stage 'Dev'
docker.image('stocksoftware/build:java-7.80.15_ruby-2.1.3').inside {
  checkout scm
  sh 'mvn -B clean install'
}
/*
node {
  checkout scm
  sh "buildr clean package"
}
*/
stage 'Qa'
input message: "Does package look good?"

