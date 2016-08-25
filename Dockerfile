##docker image for metaphlan 2
##link: https://bitbucket.org/biobakery/metaphlan2

FROM d.quantibio.com/ubuntu:14.04
MAINTAINER muquanhua@quantibio.com

#install dependencies first

RUN apt-get update  && apt-get install -y \
        wget \
        make \
        cmake \
        build-essential \
        python \
        python-dev \
        python-setuptools \
        python-pip \
        gcc \
        g++ \
        gfortran \
        unzip \
        zip \
        libev-dev \
        libblas-dev \
        liblapack-dev \
        libatlas-base-dev \
        libhdf5-dev \
        libtbb-dev

RUN pip install numpy \
        && pip install scipy \
        && pip install h5py \
        && pip install biom-format


# install bowtie2
RUN wget https://sourceforge.mirrorservice.org/b/bo/bowtie-bio/bowtie2/2.2.9/bowtie2-2.2.9-source.zip \
        && unzip bowtie2-2.2.9-source.zip \
        && mv bowtie2-2.2.9 bowtie2 \
        && cd bowtie2 \
        && make WITH_TBB=1 \
        && cd .. \
        && rm bowtie2-2.2.9-source.zip


###Then install metaphlan2
RUN     wget https://bitbucket.org/biobakery/metaphlan2/get/default.zip
RUN     unzip default.zip \
        && rm default.zip \
        && mv biobakery-metaphlan2* metaphlan2 \
        && cd metaphlan2 \
        && echo "export PATH=$PATH:/bowtie2:${PWD}" >> /root/.bashrc \
        && echo "export mpa_dir=${PWD}" >> /root/.bashrc
