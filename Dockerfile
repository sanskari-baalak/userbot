FROM python:slim-buster

RUN apt update && apt upgrade -y && \
    apt install --no-install-recommends -y \
        bash \
        curl \
        ffmpeg \
        gcc \
        git \
        libjpeg-dev \
        libjpeg62-turbo-dev \
        libwebp-dev \
        musl \
        musl-dev \
        atomicparsley \
        neofetch \
        rsync \
        zlib1g \
        zlib1g-dev

COPY . /tmp/userbot_local
WORKDIR /usr/src/app/DraculaUserBot/

RUN git clone https://github.com/devil-shiva/draculauserbot.git /usr/src/app/DraculaUserBot/
RUN rsync --ignore-existing --recursive /tmp/userbot_local/ /usr/src/app/DraculaUserBot/

RUN python3 -m pip install --upgrade pip
RUN python3 -m pip install --no-warn-script-location --no-cache-dir -r requirements.txt

RUN rm -rf /var/lib/apt/lists /var/cache/apt/archives /tmp
CMD ["python", "-m", "handlers"]
