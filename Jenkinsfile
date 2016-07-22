stage 'Dev'
node {
  checkout scm
  sh "buildr clean package"
}

stage 'Qa'
input message: "Does package look good?"

