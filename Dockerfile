FROM ubuntu:22.04

# 使用 root（預設已是 root，這裡只是顯示）
USER root

# 更新套件庫與安裝基本工具
RUN apt-get update && apt-get install -y \
    sudo \
    curl \
    wget \
    git \
    nano \
    net-tools \
    proxychains \
    tor \
    python3 \
    python3-pip \
    python3-dev \
    build-essential \
    iputils-ping \
    && apt-get clean

# 安裝 Python 套件
RUN pip3 install --upgrade pip && pip3 install \
    jupyter \
    requests[socks]

# 可選：安裝 gsocket（需依照你用途）
# RUN curl -fsSL https://gsocket.io/x | bash

# 建立一個使用者（可選）
RUN useradd -m notebookuser && echo "notebookuser ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# 設定工作資料夾
WORKDIR /home/notebookuser

# 預設開啟 Jupyter Notebook，開放所有IP連線
CMD ["jupyter", "notebook", "--ip=0.0.0.0", "--no-browser", "--allow-root", "--NotebookApp.token=''", "--NotebookApp.password=''"]
