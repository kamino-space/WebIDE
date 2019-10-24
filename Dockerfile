FROM java:8

EXPOSE 8080

RUN set -ex && \
    rm /etc/apt/sources.list.d/* && \
    echo "deb http://mirrors.tencentyun.com/debian jessie main contrib non-free\ndeb http://mirrors.tencentyun.com/debian jessie-updates main contrib non-free\ndeb-src http://mirrors.tencentyun.com/debian jessie main contrib non-free\ndeb-src http://mirrors.tencentyun.com/debian jessie-updates main contrib non-free" > /etc/apt/sources.list && \
    apt update && \
    apt install -y zsh git openssl && \
    git clone --depth=1 git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh && \
	cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc && \
    wget -O /tmp/node-v12.13.0-linux-x64.tar.xz https://npm.taobao.org/mirrors/node/v12.13.0/node-v12.13.0-linux-x64.tar.xz && \
    xz -d /tmp/node-v12.13.0-linux-x64.tar.xz && \
    tar -xvf /tmp/node-v12.13.0-linux-x64.tar -C /usr/lib && \
    mv /usr/lib/node-v12.13.0-linux-x64/ /usr/lib/nodejs && \
    echo 'export PATH="$PATH:/usr/lib/nodejs/bin:"' >> /etc/profile && \
    source /etc/profile && \
    npm config set registry http://mirrors.tencentyun.com/npm/ && \
    npm install -g yarn && \
    yarn config set registry http://mirrors.tencentyun.com/npm/ && \
    rm /tmp/* -r

ENV SHELL /bin/zsh

ADD backend/target/ide-backend.jar /root
ADD backend/src/main/resources/lib /root/lib

WORKDIR /root
CMD ["java", "-jar", "ide-backend.jar", "--PTY_LIB_FOLDER=/root/lib"]
