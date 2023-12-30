FROM centos:7

RUN yum update -y && \
    yum install -y epel-release gcc python3 python3-pip xorg-x11-server-Xvfb gtk3 wget unzip git

USER root
WORKDIR /usr/bin

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

RUN mv /usr/local/lib/python3.6 /usr/bin

#Install chrome
RUN curl -O  https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm
RUN yum install -y google-chrome-stable_current_x86_64.rpm
RUN mv /usr/bin/google-chrome-stable /usr/bin/google-chrome

RUN wget https://edgedl.me.gvt1.com/edgedl/chrome/chrome-for-testing/120.0.6099.109/linux64/chromedriver-linux64.zip
RUN unzip chromedriver-linux64.zip
RUN mv chromedriver-linux64/chromedriver /usr/bin
RUN chmod +x /usr/bin/chromedriver

#install aws cli
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
RUN unzip awscliv2.zip && ./aws/install

#setting python environment
#RUN python3 -m venv /automation_Robot_app
#RUN source /automation_Robot_app/bin/activate
WORKDIR /automation_Robot_app
COPY test2.sh .
RUN chmod +x test2.sh

EXPOSE 5900

CMD ["robot"]