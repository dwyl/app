FROM pierrezemb/gostatic
COPY /build/web/ /srv/http/
CMD ["-port","8080","-https-promote", "-enable-logging"]
