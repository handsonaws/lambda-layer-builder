FROM amazonlinux:2023
RUN ulimit -n 1024 && yum -y update && yum -y install \
    python3.11\
    python3.11-pip\
    python3.11-devel \
    zip \
    && yum clean all
RUN python3.11 -m pip install pip==23.2.1 
RUN pip install virtualenv==20.24.3
