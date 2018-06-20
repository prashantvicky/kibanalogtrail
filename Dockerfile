FROM docker.elastic.co/kibana/kibana-oss:6.2.2

RUN kibana-plugin install https://github.com/sivasamyk/logtrail/releases/download/v0.1.27/logtrail-6.2.2-0.1.27.zip

RUN mv /usr/share/kibana/plugins/logtrail/logtrail.json /usr/share/kibana/config/logtrail.json && \
    ln -s /usr/share/kibana/config/logtrail.json /usr/share/kibana/plugins/logtrail/logtrail.json
