# Use CentOS 7 as the base image
FROM centos:7

# Update the package repository and install necessary tools
RUN yum -y update && yum -y install \
    epel-release \
    wget \
    unzip \
    gnupg2 \
    gcc \
    make \
    libX11 \
    libXcomposite \
    libXcursor \
    libXdamage \
    libXext \
    libXi \
    libXtst \
    libXrandr \
    libXScrnSaver \
    libXt \
    xorg-x11-fonts-Type1 \
    xorg-x11-fonts-75dpi \
    xorg-x11-fonts-cyrillic \
    xorg-x11-server-Xvfb \
    xorg-x11-fonts-misc

# Install Python 3.7
#RUN yum -y install yum-utils && \
#    yum -y install https://centos7.iuscommunity.org/ius-release.rpm && \
#    yum -y install python37u python37u-pip

RUN wget https://www.python.org/ftp/python/3.7.12/Python-3.7.12.tgz && \
    tar xzf Python-3.7.12.tgz && \
    cd Python-3.7.12 && \
    ./configure --enable-optimizations && \
    make altinstall

RUN yum -y install yum-utils && \
    yum -y install python37u python37u-pip

# Install Chrome browser
RUN wget https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm && \
    yum -y install ./google-chrome-stable_current_x86_64.rpm && \
    rm -f google-chrome-stable_current_x86_64.rpm

# Install Chromedriver
RUN wget -qP /tmp/ "https://edgedl.me.gvt1.com/edgedl/chrome/chrome-for-testing/120.0.6099.109/linux64/chromedriver-linux64.zip" && \
    unzip /tmp/chromedriver_linux64.zip -d /usr/local/bin/ && \
    rm /tmp/chromedriver_linux64.zip && \
    chmod +x /usr/local/bin/chromedriver

# Install Robot Framework and necessary Python packages
RUN pip3.7 install --upgrade pip \
    robotframework \
    robotframework==5 \
    wheel==0.37.0 \
    robotframework-selenium2library==3.0.0 \
    robotframework-seleniumlibrary==5.1.3 \
    selenium==3.141.0 \
    setuptools==47.1.0 \
    robotframework-requests \
    robotframework-pabot==1.0.0 \
    pyautoit \
    autoit

# Set environment variables
ENV PATH="/usr/local/bin:${PATH}"
ENV LC_ALL=en_US.utf-8
ENV LANG=en_US.utf-8

# Set working directory
WORKDIR /automation_Robot_app
COPY test2.sh .
RUN chmod +x test2.sh

# Copy your test scripts or mount them as a volume
# COPY . .

# Define command to execute tests (Example command)
#CMD ["robot", "--outputdir", "/robotframework/reports", "/robotframework/tests"]