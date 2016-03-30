FROM debian:stable

RUN apt-get update && apt-get install -y wget

# Download Sophos
RUN wget http://downloads.sophos.com/inst/mVmFIiepyqqvUm9Mo2q8SAZD00ODQ0/sav-linux-free-9.tgz -O /tmp/sophos.tgz -q --show-progress --progress=dot:giga && \
    cd /tmp && tar -xzvf /tmp/sophos.tgz

# Unattended install Sophos AV Free, automatically answer the questions
RUN printf '\nN\n\nf\n\n' | /tmp/sophos-av/install.sh --acceptlicence --autostart=False

# Once installed, update. Trying to work around timing problems with the sleep.
RUN sleep 5 && /opt/sophos-av/bin/savupdate

# We've installed and updated Sophos, here's our CID. Most users can ignore this.
VOLUME [ "/opt/sophos-av/update/cache/Primary/" ]

COPY ./entrypoint.sh /
# Update, then run.
ENTRYPOINT ["/entrypoint.sh"]

CMD ["savscan", "-h"]
