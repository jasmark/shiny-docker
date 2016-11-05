FROM ubuntu:xenial

MAINTAINER Jason Mark "jason.mark.01@gmail.com"

# Fetching the key that signs the CRAN packages
# Reference: http://cran.rstudio.com/bin/linux/ubuntu/README.html
# RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E084DAB9

RUN apt-get update && apt-get install -y \
    r-base \
    wget \
    gdebi-core \
    libssl-dev

# Install R packages
RUN R -e "install.packages('shiny', repos='http://cran.rstudio.com/')" && \
    R -e "install.packages('rmarkdown', repos='http://cran.rstudio.com/')" && \
    R -e "install.packages('shinythemes', repos='http://cran.rstudio.com/')" && \
    R -e "install.packages('shinydashboard', repos='http://cran.rstudio.com/')" && \
    R -e "install.packages('dplyr', repos='http://cran.rstudio.com/')" && \
    R -e "install.packages('scales', repos='http://cran.rstudio.com/')" && \
    R -e "install.packages('lubridate', repos='http://cran.rstudio.com/')" && \
    R -e "install.packages('ggplot2', repos='http://cran.rstudio.com/')" && \
    R -e "install.packages('labeling', repos='http://cran.rstudio.com/')" && \
    R -e "install.packages('reshape2', repos='http://cran.rstudio.com/')" && \
    R -e "install.packages('gridExtra', repos='http://cran.rstudio.com/')" && \
    R -e "options(repos='http://cran.rstudio.com/');"


# Download and install Shiny Server
WORKDIR /tmp/
RUN wget http://download3.rstudio.org/ubuntu-12.04/x86_64/shiny-server-1.5.0.831-amd64.deb && \
    gdebi -n shiny-server-1.5.0.831-amd64.deb && \
    rm shiny-server-1.5.0.831-amd64.deb

EXPOSE 3838

ENV LANG pt_BR.UTF-8

# shiny user is created by the Shiny Server package installed above
# Change the UID/GID of shiny user/group, ownership of files and start
# shiny-server
RUN groupmod -g 999 shiny && \
    usermod -u 999 shiny && \
    chown -R 999:999 /home/shiny && \
    chown -R 999:999 /var/log/shiny-server && \
    chown -R 999:999 /srv/shiny-server && \
    chown -R 999:999 /var/lib/shiny-server
    
CMD ["/usr/bin/shiny-server"]