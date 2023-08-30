pipeline {
    agent any
    environment {
        TEST_PORT = 2211
        PROD_PORT = 9540
    }
    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    echo '==>Building Test Container....'
                    sh 'docker build -t practice-test .'
                    echo '==>Test Container Build Success.'
                }
            }
        }
        stage('Run Tag Docker Image') {
            steps {
                script {
                    echo '==>Adding Tag Test Container....'
                    sh 'docker tag practice-test practice-test:test'
                    echo '==>Tag Added Test Container.'
                }
            }
        }
        stage('Check Test Docker Image And Remove If Exist') {
            steps {
                script {
                    def containerExistsOutput = sh(script: "docker ps -a --filter name=practice-test-test --format '{{.Names}}'", returnStdout: true).trim()
                    def imageExistsOutput = sh(script: 'docker images -q practice-test-test', returnStdout: true).trim()
                    if (containerExistsOutput) {
                        echo 'Container exists. Stopping and removing...'
                        sh 'docker stop practice-test-test'
                        sh 'docker rm practice-test-test'
            } else {
                        echo 'Container does not exist.'
                    }
                    if (imageExistsOutput) {
                        echo 'Image exists. Removing...'
                        sh """docker rmi -f \$(docker images 'practice-test' -a -q)"""
            } else {
                        echo 'Image does not exist.'
                    }
                }
            }
        }

        stage('Run Test Docker Image') {
            steps {
                script {
                    echo '==>Running Test Container....'
                    sh "docker run -d -p $TEST_PORT:$TEST_PORT --name practice-test-test --env-file .env practice-test:test"
                    echo '==>Test Container Running.'
                }
            }
        }
        stage('Test Docker Image') {
            steps {
                script {
                    echo '==>Running Test Cases....'
                    sh 'docker exec practice-test-test npm test'
                }
            }
        }
        stage('Remove test docker image') {
            steps {
                script {
                    echo '==>Removing Test Container And Image....'
                    sh 'docker stop practice-test-test'
                    sh 'docker rm practice-test-test'
                    sh """docker rmi -f \$(docker images 'practice-test:test' -a -q)"""
                    echo '==>Removed Test Container And Image'
                }
            }
        }
        stage('Check Production Docker Image And Remove If Exist') {
            steps {
                script {
                    def containerExistsOutput = sh(script: "docker ps -a --filter name=practice-test --format '{{.Names}}'", returnStdout: true).trim()
                    def imageExistsOutput = sh(script: 'docker images -q golamrabbani3587/practice-test', returnStdout: true).trim()

                    if (containerExistsOutput) {
                        echo 'Container exists. Stopping and removing...'
                        sh 'docker stop practice-test'
                        sh 'docker rm practice-test'
            } else {
                        echo 'Container does not exist.'
                    }
                    if (imageExistsOutput) {
                        echo 'Image exists. Removing...'
                        sh """docker rmi -f \$(docker images 'golamrabbani3587/practice-test' -a -q)"""
            } else {
                        echo 'Image does not exist.'
                    }
                }
            }
        }
        stage('Build Production Docker Image') {
            steps {
                echo '==>Building Production Container...'
                sh 'docker build -t golamrabbani3587/practice-test:v1 .'
                echo '==>Successfully Build.'
            }
        }
        stage('Run Docker Image') {
            steps {
                echo '==>Running Production Container...'
                sh "docker run -d -p $PROD_PORT:$PROD_PORT --name practice-test --env-file .env golamrabbani3587/practice-test:v1"
                echo '==>Successfully Running.'
            }
        }
        stage('Push Docker Image') {
            steps {
                script {
                    def commitMessage = sh(script: "git log --format=%s -n 1", returnStdout: true).trim()
                    def imageTag = "golamrabbani3587/practice-test:${commitMessage}"
                    echo "==>Pushing $imageTag Container to Docker Hub"
                    sh "echo 'Programming123#' | docker login -u golamrabbani3587 --password-stdin"
                    sh "docker tag golamrabbani3587/practice-test:v1 $imageTag"
                    sh "docker push $imageTag"
                }
            }
        }
    }
}
