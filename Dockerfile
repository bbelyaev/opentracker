FROM alpine 
RUN apk --update add git gcc make g++ zlib-dev cvs sed && \
cd /tmp && \
cvs -d :pserver:cvs@cvs.fefe.de:/cvs -z9 co libowfat && cd libowfat && \
make && cd .. && \
git clone git://erdgeist.org/opentracker && cd opentracker && \
sed -i \ 
    -e "s/#define OT_CLIENT_TIMEOUT 30/#define OT_CLIENT_TIMEOUT 5/g" \ 
    -e "s/#define OT_CLIENT_TIMEOUT_CHECKINTERVAL 10/#define OT_CLIENT_TIMEOUT_CHECKINTERVAL 3/g" \ 
    trackerlogic.h && \
make && \
apk del gcc make g++ zlib-dev cvs sed && \
mv /tmp/opentracker/opentracker /bin/  && \
rm -rf /var/cache/apk/* /tmp/* && \
touch /etc/opentracker.conf
COPY entrypoint.sh /
EXPOSE 6969 80 
ENTRYPOINT ["sh", "entrypoint.sh"]
