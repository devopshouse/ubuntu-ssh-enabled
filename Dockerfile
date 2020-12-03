FROM ubuntu

LABEL author="DevOpsHouse"
LABEL version="1.0"
LABEL description="SSH Enabled Ubuntu Image for Test and Dev purposes ONLY!"
LABEL note="THIS IMAGE IS TO BE USED FOR TEST AND LEARNIGN PURPOSES ONLY! NOT TO BE USED IN A PRODUCTION ENVIRONMENT!"

RUN apt-get update && apt-get install -y openssh-server net-tools iproute2 iputils-ping curl wget
RUN mkdir /var/run/sshd

# Setting root password
RUN echo 'root:Passw0rd' | chpasswd

# Enabling root login 
RUN sed -i 's/.*PermitRootLogin.*/PermitRootLogin yes/' /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
