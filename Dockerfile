FROM busybox

ADD _book/ /artefact
WORKDIR /artefact
ADD bin/pub-artefact /
ADD bin/set_doc_version.sh /usr/bin/
RUN ["/bin/busybox","sh","/pub-artefact","/usr/share/nginx/html"]]
RUN ["/bin/busybox","sh","/pub-artefact","/var/www/html/docs"]]

CMD ["sh", "-c", "set_doc_version.sh gitbook/plugins/gitbook-plugin-onedata-theme/onedata.js"]
