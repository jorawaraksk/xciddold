FROM python:3.9-slim-bullseye
RUN apt-get update && apt-get install -y --no-install-recommends \
        git wget pv jq python3-dev mediainfo \
    && rm -rf /var/lib/apt/lists/*

COPY --from=mwader/static-ffmpeg:7.0 /ffmpeg  /usr/local/bin/ffmpeg
COPY --from=mwader/static-ffmpeg:7.0 /ffprobe /usr/local/bin/ffprobe

WORKDIR /bot
COPY . .
RUN pip3 install --no-cache-dir -r requirements.txt
EXPOSE 8080

CMD ["bash", "run.sh"]
