FROM teamcity-base:latest
MAINTAINER Kateryna Shlyakhovetska <shkate@jetbrains.com>

ENV TEAMCITY_DATA_PATH=/data/teamcity_server/datadir \
    TEAMCITY_DIST=/opt/teamcity \
    TEAMCITY_LOGS=/opt/teamcity/logs

EXPOSE 8111
LABEL dockerImage.teamcity.version="latest" \
      dockerImage.teamcity.buildNumber="latest"

COPY run-services.sh /run-services.sh
RUN chmod +x /run-services.sh && sync
COPY dist/teamcity $TEAMCITY_DIST

VOLUME $TEAMCITY_DATA_PATH \
       $TEAMCITY_LOGS
       
RUN apt-get -y update  && apt-get install -y wget
RUN echo "deb http://package.perforce.com/apt/ubuntu/ trusty release" > /etc/apt/sources.list.d/perforce.list
#RUN wget -qO - https://package.perforce.com/perforce.pubkey | apt-key add -
RUN apt-get -y update && apt-get install -y helix-cli --force-yes

CMD ["/run-services.sh"]
