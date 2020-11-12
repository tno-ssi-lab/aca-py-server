FROM bcgovimages/von-image:py36-1.15-0

RUN pip3 install aries-cloudagent

EXPOSE 9000

ENTRYPOINT ["/bin/bash", "-c", "aca-py \"$@\"", "--"]

CMD [ "start" ]
