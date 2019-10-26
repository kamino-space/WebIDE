FROM openjdk:8u232-jre
LABEL maintainer="kamino <kamino@imea.me>"
EXPOSE 8080
WORKDIR /root

RUN echo "deb http://mirrors.tencentyun.com/debian stretch main contrib non-free\ndeb http://mirrors.tencentyun.com/debian stretch-updates main contrib non-free\ndeb-src http://mirrors.tencentyun.com/debian stretch main contrib non-free\ndeb-src http://mirrors.tencentyun.com/debian stretch-updates main contrib non-free" > /etc/apt/sources.list && \
    apt update && \
    apt install -y zsh git openssl && \
    git clone --depth=1 git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh && \
	cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc

ENV SHELL /bin/zsh

ADD ide-backend.jar /root
ADD lib /root/lib

CMD ["java", "-jar", "ide-backend.jar", "--PTY_LIB_FOLDER=/root/lib"]
