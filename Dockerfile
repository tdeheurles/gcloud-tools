# From https://github.com/GoogleCloudPlatform/cloud-sdk-docker
FROM        google/debian:wheezy
MAINTAINER  tdeheurles@gmail.com

RUN apt-get update

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get install -y zsh
RUN apt-get install -y curl
RUN apt-get install -y git
RUN apt-get install -y -qq --no-install-recommends wget
RUN apt-get install -y -qq --no-install-recommends unzip
RUN apt-get install -y -qq --no-install-recommends python
# RUN apt-get install -y -qq --no-install-recommends php5-mysql
# RUN apt-get install -y -qq --no-install-recommends php5-cli
# RUN apt-get install -y -qq --no-install-recommends php5-cgi
# RUN apt-get install -y -qq --no-install-recommends openjdk-7-jre-headless
# RUN apt-get install -y -qq --no-install-recommends openssh-client
# RUN apt-get install -y -qq --no-install-recommends python-openssl

RUN wget https://dl.google.com/dl/cloudsdk/release/google-cloud-sdk.zip
RUN unzip google-cloud-sdk.zip
RUN rm google-cloud-sdk.zip

ENV CLOUDSDK_PYTHON_SITEPACKAGES 1
RUN google-cloud-sdk/install.sh --usage-reporting=true --path-update=true --bash-completion=true --rc-path=/.bashrc --disable-installation-options
#RUN google-cloud-sdk/bin/gcloud --quiet components update pkg-go pkg-python pkg-java
RUN google-cloud-sdk/bin/gcloud --quiet components update preview
RUN google-cloud-sdk/bin/gcloud --quiet components update alpha
RUN google-cloud-sdk/bin/gcloud --quiet components update beta
#RUN google-cloud-sdk/bin/gcloud --quiet components update preview app
RUN google-cloud-sdk/bin/gcloud --quiet components update kubectl
RUN google-cloud-sdk/bin/gcloud --quiet config set component_manager/disable_update_check true
RUN mkdir /.ssh

ENV PATH /google-cloud-sdk/bin:$PATH
ENV HOME /

# Oh-My-Zsh
RUN curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | bash

RUN apt-get remove wget -y
RUN apt-get remove unzip -y
RUN apt-get remove python -y
RUN apt-get remove curl -y
RUN apt-get remove git -y
RUN apt-get clean

VOLUME ["/.config"]

#CMD ["/bin/zsh"]
