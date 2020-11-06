FROM bcgovimages/von-image:py36-1.15-0

RUN pip3 install aries-cloudagent

# RUN mkdir logs && chown -R indy:indy logs && chmod -R ug+rw logs

ENTRYPOINT ["/bin/bash", "-c", "aca-py \"$@\"", "--"]

CMD [ "start" ]
