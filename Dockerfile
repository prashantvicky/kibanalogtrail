FROM centos:7.4.1708
LABEL maintainer="prashant.vicky@gmail.com" \
	  version="6.2.2" \
	  project="kibana"
EXPOSE 5601
ARG KIBANA_VERSION=6.2.2
ENV container docker \
    PACKAGE_VERSION=${KIBANA_VERSION}
ARG APP_HOME=/kibana
RUN yum install -y -q wget && \
	groupadd -g 405 kibana && \
	useradd -u 405 -g 405 kibana && \
	wget -q -O /tmp/kibana.tar.gz https://artifacts.elastic.co/downloads/kibana/kibana-${KIBANA_VERSION}-linux-x86_64.tar.gz && \
	tar -xzf /tmp/kibana.tar.gz -C / && \
	ln -sf /kibana-${KIBANA_VERSION}-linux-x86_64 ${APP_HOME} && \
	mkdir -p /var/log/kibana /etc/kibana && \
	rm -rf /tmp/kibana.tar.gz && \
    	touch /var/log/kibana/kibana.log 
COPY setup/config/kibana.yml /etc/kibana/kibana.yml
ADD setup/scripts /kibana/
RUN chown -R kibana:kibana /kibana-${KIBANA_VERSION}-linux-x86_64 /var/log/kibana /etc/kibana && \
	/kibana/bin/kibana-plugin install https://github.com/sivasamyk/logtrail/releases/download/v0.1.27/logtrail-6.2.2-0.1.27.zip
COPY setup/config/logtrail.json /kibana/plugins/logtrail/logtrail.json
ENTRYPOINT ["/kibana/kibana.sh"]
