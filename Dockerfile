FROM appropriate/curl:latest
COPY ./config/bootstrap.sh /init/
ENV APICONTAINER check-yo-self-api
RUN ["dos2unix", "/init/bootstrap.sh"]
ENTRYPOINT [ "sh", "-c", "/init/bootstrap.sh" ]