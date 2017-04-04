# docker-jenkins

        nohup docker run -p 8080:8080 -p 50000:50000 --name deployed-jenkins -v jenkins_home:/var/jenkins_home idk-jenkins &> jenkins.log &
