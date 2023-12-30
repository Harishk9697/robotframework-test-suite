FROM centos:7

RUN yum update -y && \
    yum install -y epel-releasegcc python3 python3-pip pyhton3-devel xorg-x11-server-Xvfb gtk3 wget unzip git

RUN useradd -ms /bin/bash robotuser
USER robotuser

#installing pip
RUN yum install python3-pip
RUN python3 -m pip install --upgrade pip 
RUN pip install robotframework==5
RUN pip install wheel==0.37.0 
#RUN pip install robotframework-ride==2.0.6 
RUN pip install robotframework-selenium2library==3.0.0 
RUN pip install robotframework-seleniumlibrary==5.1.3
RUN pip install selenium==3.141.0 
RUN pip install setuptools==47.1.0 
RUN pip install robotframework-requests
#RUN pip install robotframework-browser
RUN pip install  robotframework-pabot==1.0.0
RUN pip install autoit
RUN pip install pyautoit

#Install chrome
RUN curl https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm -o chrome.rpm && \
    yum install -y chrome.rpm

RUN wget https://edgedl.me.gvt1.com/edgedl/chrome/chrome-for-testing/120.0.6099.109/linux64/chromedriver-linux64.zip && \
    unzip chromedriver-linux64.zip && \
    mv chromedriver /usr/local/bin && \
    chmod +x /usr/local/bin/chromedriver

WORKDIR /automation_Robot_app
COPY test2.sh .
RUN chmod +x test2.sh

EXPOSE 5900

CMD ["robot"]