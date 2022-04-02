pipeline{

	agent any

	environment {
		DOCKERHUB_CREDENTIALS=credentials('docker-premasaik')
		POD_NAME = "tmp"
	}

	stages {

    /*
		stage('Build') {

			steps {
				sh 'docker build -t premasaik/kubernetes-101:v3 .'
			}
		}

		stage('Login') {

			steps {
				sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
			}
		}

		stage('Push') {

			steps {
				sh 'docker push premasaik/kubernetes-101:v3'
			}
		}
		*/
		stage('Deploy to K8s')
		{
			steps{
				sshagent(['premasaik-k8s'])
				{
					sh 'scp -v -r -o StrictHostKeyChecking=no /home/premasai/CICD3/mysql-deployment.yaml /home/premasai/CICD3/wordpress-deployment.yaml /home/premasai/CICD3/kustomization.yaml premasai@127.0.0.1:/home/premasai'
					
					script{
						try{
							sh 'ssh premasai@127.0.0.1 kubectl apply -k ./'
							sh 'ssh premasai@127.0.0.1 kubectl get pods | grep wordpress*'
							sleep 5
							ret1 = sh ( script:'ssh premasai@127.0.0.1 kubectl get pods | grep wordpress | awk \'{print $3}\'',returnStdout: true).trim()
							println ret1
							ret2 = sh ( script:'ssh premasai@127.0.0.1 kubectl get pods | grep kwordpress | awk \'{print $1}\'',returnStdout: true).trim()
							println "${ret2}"	
							echo "came here : ${ret2}"
							env.POD_NAME = "${ret2}"
							echo "env : ${env.POD_NAME}"
							}catch(error)
							{
							 echo "came here"
							}
					}
				}
			}
		}
	}

	post {
		always {
			sh 'docker logout '
		}
	}

}
