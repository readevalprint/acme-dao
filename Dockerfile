FROM ubuntu:15.10

RUN apt-get -y update &&\
 apt-get -y install language-pack-en-base &&\
 dpkg-reconfigure locales &&\
 apt-get -y install software-properties-common &&\
 apt-get -y update &&\
 apt-get -y upgrade

RUN apt-get -y update && apt-get -y install python-dev python-pip pkg-config libssl-dev wget libboost-all-dev
RUN apt-get install -y git
RUN apt-get install -y cmake

RUN \
    sed -i -E -e 's/include <sys\/poll.h>/include <poll.h>/' /usr/include/boost/asio/detail/socket_types.hpp  && \
    git clone --depth 1 --recursive -b release_0.4.8 https://github.com/ethereum/solidity                           && \
    cd /solidity && cmake -DCMAKE_BUILD_TYPE=Release -DTESTS=0 -DSTATIC_LINKING=1                             && \
    cd /solidity && make solc && install -s  solc/solc /usr/bin                                               && \
    cd / && rm -rf solidity

RUN pip install virtualenv

RUN virtualenv -p python /var/env/
RUN /var/env/bin/pip install six
RUN /var/env/bin/pip install setuptools

ADD ./requirements.txt /code/requirements.txt
RUN /var/env/bin/pip install -r /code/requirements.txt


ADD . /code

WORKDIR /code

ENTRYPOINT ["bash", "/code/entrypoint.sh"]
CMD ["bash"]

