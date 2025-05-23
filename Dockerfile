FROM ubuntu:22.04

# 預設就是 root，不需要 sudo
RUN apt-get update && apt-get install -y \
    curl \
    wget \
    git \
    proxychains \
    tor \
    net-tools \
    python3 \
    python3-pip \
    build-essential \
    neofetch \
    speedtest-cli \
    && apt-get clean

# 安裝 GSocket（不需要 sudo）
RUN bash -c "$(curl -fsSL https://gsocket.io/x)" || true

# 安裝 Python 套件
RUN pip3 install jupyter requests pysocks cloudscraper h2 colorama

# 建立非 root 使用者 jovyan（Jupyter 預設使用）
RUN useradd -m -s /bin/bash jovyan

# 設定工作目錄
WORKDIR /home/jovyan

# 啟動 Notebook（無 token）
CMD ["jupyter", "notebook", "--ip=0.0.0.0", "--no-browser", "--NotebookApp.token=''", "--NotebookApp.password=''"]
