FROM ubuntu:24.04

RUN apt-get update && \
  apt-get install -y git cmake ninja-build gperf \
  ccache dfu-util device-tree-compiler wget \
  python3-pip python3-setuptools python3-wheel xz-utils file make gcc g++ \
  && rm -rf /var/lib/apt/lists/*

# PEP 668対応: --break-system-packages を付ける
RUN pip3 install --break-system-packages west

WORKDIR /workspace
COPY . /workspace

RUN west init -l config && \
  west update && \
  west zephyr-export

# RUN pip3 install --break-system-packages -r zmk/zephyr/scripts/requirements.txt

WORKDIR /workspace/config
