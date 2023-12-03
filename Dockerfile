FROM debian:buster-slim

RUN  apt-get update 
RUN  apt-get -y install \
  systemd \
  build-essential \
  vim \
  curl \
  gcc \
  flex \
  bison \
  wget \
  iputils-ping \
  iproute2 \
  net-tools \
  dnsutils \
  nmap \
  lsof \
  procps \
  tcpdump \
  nano \
  pkg-config

RUN  apt-get -y install \
  libpcap0.8 \
  libpcap0.8-dev \
  libpcre3 \
  libpcre3-dev \
  libdumbnet1 \
  libdumbnet-dev \
  libdaq2 \
  libdaq-dev

RUN  apt-get -y install \
  zlib1g \
  zlib1g-dev \
  liblzma5 \
  liblzma-dev \
  luajit \
  libluajit-5.1-dev \
  libssl1.1 \
  libssl-dev \
  tcpreplay && \
  apt-get clean

RUN <<EOF
curl -L -O https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-8.11.1-amd64.deb
dpkg -i filebeat-8.11.1-amd64.deb
update-rc.d filebeat defaults
update-rc.d filebeat enable
filebeat setup
/etc/init.d/filebeat start
EOF

RUN <<EOF
wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | gpg --dearmor -o /usr/share/keyrings/elastic-keyring.gpg
apt-get install apt-transport-https
echo "deb [signed-by=/usr/share/keyrings/elastic-keyring.gpg] https://artifacts.elastic.co/packages/8.x/apt stable main" | tee -a /etc/apt/sources.list.d/elastic-8.x.list
apt-get update && apt-get install logstash
EOF



