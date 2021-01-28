FROM bcgovimages/von-image:py36-1.15-0

USER root

# Fix vulnerable depedency
RUN apt-get update && \
    apt-get --only-upgrade install libssl-dev libssl1.1 && \
    rm -rf /var/lib/apt/lists

USER indy

RUN pip3 install wheel && \
    pip3 install aries-cloudagent

EXPOSE 9000

ENTRYPOINT ["/bin/bash", "-c", "aca-py \"$@\"", "--"]

CMD [ "start" ]
