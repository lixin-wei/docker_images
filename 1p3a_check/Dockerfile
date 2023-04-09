# Images for 1p3a auto check-in
# 1. crontab is set & enabled.
# 2. CMD is sshd, usr/pwd: root/root.
# You need:
# 1. docker run -d --restart always -p 2222:22 wlx65003/1p3a_check
# 2. ssh to the container
# 3. Configure `/root/1point3acres/configure/cookie.json`.

FROM wlx65003/ubuntu-sshd

# crontab
COPY crontab.txt /root/crontab.txt
RUN crontab /root/crontab.txt && rm /root/crontab.txt

# auto-check scripts
COPY 1p3a_check.sh /root/1p3a_check.sh
RUN cd ~ && git clone https://github.com/lixin-wei/1point3acres.git && \
    cd 1point3acres && \
    git remote set-url origin git@github.com:lixin-wei/1point3acres.git && \
    pip install -r requirements.txt
