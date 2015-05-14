# Start from a Java 7 image.
FROM java:7

# Download ignite.
ADD http://apache-mirror.rbc.ru/pub/apache/incubator/ignite/1.0.0/ignite-fabric-1.0.0-incubating.zip .

RUN mv ignite-fabric-1.0.0-incubating.zip /home

WORKDIR /home

# Unzip
RUN unzip ignite-fabric-1.0.0-incubating.zip

RUN rm ignite-fabric-1.0.0-incubating.zip

RUN mv ignite-fabric-1.0.0-incubating ignite

WORKDIR ./ignite

# Use aws optional libs.
RUN cp -R ./libs/optional/ignite-aws/* ./libs/

# Copy script and default config for ec2
ADD ignite-ec2-config.xml ./

ADD startup.sh ./

RUN chmod +x startup.sh

# Start ignite.
CMD ./bin/ignite.sh