FROM ubuntu:24.04


ENV DEBIAN_FRONTEND=noninteractive


# Ставлю sudo и openssh
RUN apt-get update \
&& apt-get install -y --no-install-recommends openssh-server sudo ca-certificates curl unzip gnupg2 \
&& rm -rf /var/lib/apt/lists/*


#  Настраиваю ssh
RUN mkdir /var/run/sshd


# Создаю юзера для доступа по ssh
RUN useradd -m -s /bin/bash tester \
&& echo "tester:password" | chpasswd \
&& usermod -aG sudo tester


# Ставлю пароль откртым, так как это тест. На рабочей задаче спрятал бы его за переменной
RUN sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config || true


EXPOSE 22
EXPOSE 80


CMD ["/usr/sbin/sshd", "-D"]
