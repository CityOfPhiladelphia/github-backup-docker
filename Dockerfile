FROM ubuntu:latest

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y git && \
    apt-get install curl -y && \
    apt-get install python -y


RUN curl -O https://bootstrap.pypa.io/get-pip.py
RUN python get-pip.py
RUN pip install github-backup && \
    pip install awscli --upgrade


WORKDIR /home
COPY backup.sh ./
RUN chmod +x ./backup.sh

# TODO: Determine how to back up initially to reduce backup time.
# RUN github-backup CityOfPhiladelphia --token $ACCESS_TOKEN --organization -o backup/ --repositories -i
CMD ["./backup.sh"]
