FROM centos:7

USER root
WORKDIR /usr/bin

RUN yum -y update && yum -y install \
    epel-release \
    sudo \
    gcc \
    xorg-x11-server-Xvfb \
    gtk3 \
    wget \
    unzip \
    git \
    libXScrnSaver \
    GConf2 \
    make \
    zlib-devel \
    libffi-devel \
    openssl-devel \
    bzip2-devel \
    xz-devel \
    readline-devel \
    sqlite-devel \
    tar \
    perl \
    Xvfb

#Install chrome
RUN curl -O  https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm
RUN yum -y install google-chrome-stable_current_x86_64.rpm
#RUN mv /usr/bin/google-chrome-stable /usr/bin/google-chrome
#RUN mv /opt/google /usr/bin
#RUN mv  /usr/bin/google/chrome/chrome /usr/bin
#ENV CHROME_PATH=/usr/bin/google-chrome
#ENV PATH=$CHROME_PATH:$PATH

RUN wget https://edgedl.me.gvt1.com/edgedl/chrome/chrome-for-testing/120.0.6099.109/linux64/chromedriver-linux64.zip
RUN unzip chromedriver-linux64.zip
RUN rm -rf chromedriver-linux64.zip
RUN mv -f chromedriver-linux64/chromedriver /usr/bin/chromedriver
RUN chmod 0755 /usr/bin/chromedriver

#install aws cli
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
RUN unzip awscliv2.zip && ./aws/install

## Install Node.js
RUN curl -sL https://rpm.nodesource.com/setup_16.x | sudo bash -
RUN yum -y install nodejs


## Install python
# Download and install Python 3.7
RUN wget https://www.python.org/ftp/python/3.7.12/Python-3.7.12.tgz && \
    tar xzf Python-3.7.12.tgz && \
    cd Python-3.7.12 && \
    ./configure --enable-optimizations && \
    make altinstall

# Cleanup
RUN rm -rf Python-3.7.12.tgz && \
    yum clean all && \
    rm -rf /var/cache/yum

# Download and install OpenSSL 1.1.1l (replace version number as needed)
RUN wget https://www.openssl.org/source/openssl-1.1.1l.tar.gz && \
    tar -zxvf openssl-1.1.1l.tar.gz && \
    cd openssl-1.1.1l && \
    ./config --prefix=/usr/local/openssl --openssldir=/usr/local/openssl shared && \
    make && \
    make install && \
    rm -rf /openssl-1.1.1l.tar.gz /openssl-1.1.1l

#RUN yum update -y
#RUN yum install -y python3

#setting python environment
RUN python3.7 -m venv /automation_Robot_app
RUN source /automation_Robot_app/bin/activate

WORKDIR /automation_Robot_app
COPY test2.sh .
RUN chmod +x test2.sh

#installing pip
RUN yum install -y python3-pip
RUN python3.7 -m pip install --upgrade pip 

RUN pip install robotframework==5
RUN pip install wheel==0.41.0 
#RUN pip install robotframework-ride==2.0.6 
RUN pip install robotframework-selenium2library==3.0.0 
RUN pip install robotframework-seleniumlibrary==5.1.3
RUN pip install selenium==4.9.0
RUN pip install setuptools==47.1.0 
RUN pip install robotframework-requests
#RUN pip install wxPython
#RUN pip install chromedriver-binary
RUN pip install robotframework-pabot==1.0.0
RUN pip install pyautoit
#RUN pip install robotframework-browser
#RUN rfbrowser init

RUN rm -f /usr/bin/python3

# Verify Python installation
RUN python3.7 --version

# Set symbolic link for python3 to refer to Python 3.7
RUN ln -s /usr/local/bin/python3.7 /usr/bin/python3

CMD ["robot"]