stage 'Dev'
docker.image('stocksoftware:3.3.3-jdk-8').inside {
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

