FROM java:8

EXPOSE 8080

RUN set -ex && \
    rm /etc/apt/sources.list.d/* && \
    echo "deb http://mirrors.tencentyun.com/debian jessie main contrib non-free\ndeb http://mirrors.tencentyun.com/debian jessie-updates main contrib non-free\ndeb-src http://mirrors.tencentyun.com/debian jessie main contrib non-free\ndeb-src http://mirrors.tencentyun.com/debian jessie-updates main contrib non-free" > /etc/apt/sources.list && \
    apt update && \
    apt install -y zsh git openssl

# Install oh-my-zsh
RUN git clone --depth=1 git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh \
	&& cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc

ENV SHELL /bin/zsh

ADD backend/target/ide-backend.jar /root
ADD backend/src/main/resources/lib /root/lib

WORKDIR /root
CMD ["java", "-jar", "ide-backend.jar", "--PTY_LIB_FOLDER=/root/lib"]
