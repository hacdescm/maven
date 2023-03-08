FROM maven:3.6.3-openjdk-11

RUN apt-get update && \
    apt-get install wget zip

RUN apt-get install -y --no-install-recommends fontconfig

RUN cd /usr/local/share/ca-certificates; \
    wget -q https://github.com/hacdescm/certs/archive/master.zip; \
    unzip -j master.zip; \
    rm master.zip

RUN update-ca-certificates

RUN cd /usr/local/share/ca-certificates; \
      keytool -cacerts -storepass changeit -noprompt -trustcacerts -importcert -alias ha-enterprise-ca3 -file ./ha-enterprise-ca3.crt; \
      keytool -cacerts -storepass changeit -noprompt -trustcacerts -importcert -alias ha-root-ca1 -file ./ha-root-ca1.crt; \
      keytool -cacerts -storepass changeit -noprompt -trustcacerts -importcert -alias ha-trial-root-ca1 -file ./ha-trial-root-ca1.crt
