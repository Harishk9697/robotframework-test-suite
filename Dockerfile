FROM centos:7

USER root

RUN yum update -y && \
    yum install -y epel-release gcc xorg-x11-server-Xvfb gtk3 wget unzip git libXScrnSaver GConf2 ipa-gothic-fonts xorg-x11-fonts-100dpi xorg-x11-fonts-75dpi xorg-x11-utils xorg-x11-fonts-cyrillic xorg-x11-fonts-Type1 xorg-x11-fonts-misc

#installing pip
RUN yum install -y python3-pip
RUN python3 -m pip install --upgrade pip 

#USER pwuser
RUN pip3 install --user robotframework==5
RUN pip3 install --user robotframework-browser==16.3.0
RUN ~/.local/bin/rfbrowser init
#ENV NODE_PATH=/usr/lib/node_modules
ENV PATH="/home/pwuser/.local/bin:${PATH}"

#RUN pip install robotframework==5
RUN pip install wheel==0.37.0 
#RUN pip install robotframework-ride==2.0.6 
RUN pip install robotframework-selenium2library==3.0.0 
RUN pip install robotframework-seleniumlibrary==5.1.3
RUN pip install selenium==3.141.0 
RUN pip install setuptools==47.1.0 
RUN pip install robotframework-requests
#RUN pip install robotframework-browser
RUN pip install  robotframework-pabot==1.0.0
RUN pip install pyautoit

#Install chrome
#RUN curl -O  https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm
#RUN yum -y localinstall google-chrome-stable_current_x86_64.rpm
#RUN rm -f google-chrome-stable_current_*.rpm
#RUN mv /usr/bin/google-chrome-stable /usr/bin/google-chrome
#RUN mv /usr/bin/google-chrome /usr/bin/chrome
#
#RUN wget https://edgedl.me.gvt1.com/edgedl/chrome/chrome-for-testing/120.0.6099.109/linux64/chromedriver-linux64.zip
#RUN unzip chromedriver-linux64.zip
#RUN mv chromedriver-linux64/chromedriver /usr/bin/chromedriver
#RUN rm -f chromedriver-linux64.zip
#RUN chmod +x /usr/bin/chromedriver

#install aws cli
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
RUN unzip awscliv2.zip && ./aws/install

#setting python environment
#RUN python3 -m venv /automation_Robot_app
#RUN source /automation_Robot_app/bin/activate
#WORKDIR /usr/src/app
COPY test2.sh .
RUN chmod +x test2.sh

CMD ["robot"]