FROM ubuntu:23.04
MAINTAINER "Lixin Wei"

# basic libs
RUN apt update && \
    apt install -y apt-utils man-db cron && \ 
    yes | unminimize && \
    apt upgrade -y && \
    apt clean

# sshd
RUN mkdir /run/sshd; \
    apt update && apt install -y openssh-server; \
    sed -Ei 's/^#(PermitRootLogin) .*/\1 yes/' /etc/ssh/sshd_config; \
    sed -Ei 's/^#(AllowAgentForwarding) .*/\1 yes/' /etc/ssh/sshd_config; \
    apt clean;

# entrypoint
COPY entry_point.sh /usr/local/bin/entry_point.sh

ENV TZ Asia/Shanghai

ENV ROOT_PASSWORD root

EXPOSE 22

ENTRYPOINT ["entry_point.sh"]

CMD    ["/usr/sbin/sshd", "-D", "-e"]

# -----------custom libs------------
RUN apt update && apt install -y tzdata zsh fzf git tmux vim net-tools curl && \
    apt clean

# zsh
RUN chsh -s /usr/bin/zsh
# oh-my-zsh
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" && \
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions && \
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting && \
    git clone --depth=1 https://github.com/mbenford/zsh-tmux-auto-title ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-tmux-auto-title
# oh-my-zsh config
COPY zshrc /root/.zshrc
SHELL ["/usr/bin/zsh", "-c"]
# vimrc
RUN wget https://raw.githubusercontent.com/amix/vimrc/master/vimrcs/basic.vim -O /root/.vimrc

#pyenv
RUN apt update && apt install -y build-essential libssl-dev zlib1g-dev \
    libbz2-dev libreadline-dev libsqlite3-dev curl \
    libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev && \
    apt clean

RUN curl https://pyenv.run | bash
RUN echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.zshrc && \
    echo 'command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.zshrc && \
    echo 'eval "$(pyenv init -)"' >> ~/.zshrc
RUN source /root/.zshrc && pyenv install 3.10.10 && pyenv global 3.10.10

