FROM jetty:alpine

RUN wget -O $JETTY_BASE/webapps/ROOT.war http://ftp.musicbrainz.org/pub/musicbrainz/search/servlet/searchserver.war

VOLUME ["/home/search/data"]

RUN ln -s /home/search/data /home/search/indexdata
