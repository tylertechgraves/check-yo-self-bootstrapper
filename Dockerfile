FROM appropriate/curl:latest
COPY ./config/bootstrap.sh /init/
ENV APICONTAINER check-yo-self-api
# ENV CONSULCONTAINER consul:8500
# ENV MANIFESTCONTAINER intents
RUN ["dos2unix", "/init/bootstrap.sh"]
ENTRYPOINT [ "sh", "-c", "/init/bootstrap.sh" ]