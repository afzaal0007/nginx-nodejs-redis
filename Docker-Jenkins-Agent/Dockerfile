# Dockerfile to create a Jenkins agent image  

FROM jenkins/inbound-agent  

# Install necessary tools (example: Maven and Git)  
USER root  
RUN apt-get update && apt-get install -y git maven  
USER jenkins  