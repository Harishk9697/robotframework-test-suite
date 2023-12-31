FROM centos:7

USER root
WORKDIR /usr/bin

RUN yum update -y && \
    yum install -y epel-release gcc xorg-x11-server-Xvfb gtk3 wget unzip git libXScrnSaver GConf2

#Install chrome
#RUN curl -O  https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm
#RUN yum -y localinstall google-chrome-stable_current_x86_64.rpm
#RUN rm -f google-chrome-stable_current_*.rpm
#RUN mv /usr/bin/google-chrome-stable /usr/bin/google-chrome
#ENV CHROME_PATH=/usr/bin/google-chrome
#ENV PATH=$CHROME_PATH:$PATH

#RUN wget https://edgedl.me.gvt1.com/edgedl/chrome/chrome-for-testing/120.0.6099.109/linux64/chrome-linux64.zip
#RUN unzip chrome-linux64.zip
#RUN ls
#RUN mv -f chrome-linux64/chrome /usr/bin
#ENV CHROME_PATH=usr/bin/chrome
#ENV PATH=$CHROME_PATH:$PATH

#RUN wget https://edgedl.me.gvt1.com/edgedl/chrome/chrome-for-testing/120.0.6099.109/linux64/chromedriver-linux64.zip
#RUN unzip chromedriver-linux64.zip
#RUN rm -rf chromedriver-linux64.zip
#RUN mv -f chromedriver-linux64/chromedriver /usr/local/bin/chromedriver
#RUN chmod 0755 /usr/local/bin/chromedriver

ENV PATH="/usr/local/bin:${PATH}"

#install aws cli
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
RUN unzip awscliv2.zip && ./aws/install

#setting python environment
RUN python3 -m venv /automation_Robot_app
RUN source /automation_Robot_app/bin/activate

WORKDIR /automation_Robot_app
COPY test2.sh .
RUN chmod +x test2.sh

#installing pip
RUN yum install -y python3-pip
RUN python3 -m pip install --upgrade pip 

RUN pip install robotframework==5
RUN pip install wheel==0.37.0 
#RUN pip install robotframework-ride==2.0.6 
RUN pip install robotframework-selenium2library==3.0.0 
RUN pip install robotframework-seleniumlibrary==5.1.3
RUN pip install selenium==3.141.0 
RUN pip install setuptools==47.1.0 
RUN pip install robotframework-requests
RUN pip install chromedriver-binary
RUN pip install chromium
#RUN pip install robotframework-browser
RUN pip install robotframework-pabot==1.0.0
RUN pip install pyautoit

CMD ["robot"]