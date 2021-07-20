FROM dotriver/alpine-s6

RUN apk add sshpass openssh-client rsync

ADD conf/ /

RUN chmod +x /etc/periodic/daily/*
