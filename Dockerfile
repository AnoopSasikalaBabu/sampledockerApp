FROM python:3

# install google chrome
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -
RUN sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'
RUN apt-get -y update
RUN apt-get install -y google-chrome-stable

# install chromedriver
RUN apt-get install -yqq unzip
RUN wget -O /tmp/chromedriver.zip http://chromedriver.storage.googleapis.com/`curl -sS chromedriver.storage.googleapis.com/LATEST_RELEASE`/chromedriver_linux64.zip
RUN unzip /tmp/chromedriver.zip chromedriver -d /usr/local/bin/

# set display port to avoid crash
ENV DISPLAY=:99

LABEL maintainer="Anoop Babu"

#
# Let's make sure we are always having the latest version of pip installed
#
RUN python -m pip install --upgrade pip

#
# Installing the latest robot framework version
#
RUN python3 -m pip install robotframework

#
# Installing selenium2 test library
#
RUN python3 -m pip install robotframework-selenium2library
RUN python3 -m pip install selenium
RUN python3 -m pip install robotframework-seleniumlibrary
#RUN python3 -m pip install wii-client
RUN python3 -m pip install Robotframework-requests
RUN python3 -m pip install robotframework-pabot

ADD . /usr/local/bin

#CMD ["robot", "/usr/src/project/sample-0-trivial/sample-0-trivial.txt"]

#COPY  *.tar /usr/local/bin/
#COPY  *.robot  /usr/local/bin/
#COPY docker-entrypoint.sh /usr/local/bin/
#RUN ln -s /usr/local/bin/docker-entrypoint.sh
RUN chmod 755 /usr/local/bin/docker-entrypoint.sh
ENTRYPOINT ["docker-entrypoint.sh"]
