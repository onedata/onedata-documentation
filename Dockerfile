FROM docker.onedata.org/empty-base:1.0.0

ADD _book/ /artefact
ADD pub-artefact /
ADD busybox-x86_64 /bin/busybox
RUN ["/bin/busybox","sh","/pub-artefact","/usr/share/nginx/html"]]
RUN ["/bin/busybox","sh","/pub-artefact","/var/www/html/docs"]]

#Otherwise docer-compose up fails randomly, seems to work with docker 1.10+
CMD ["/bin/busybox","tail","-f","/dev/null"]
