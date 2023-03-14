FROM ubuntu:jammy
ENV DEBIAN_FRONTEND noninteractive
RUN apt update && apt-get -y install git wget mc aptitude nano sudo curl software-properties-common build-essential apt-utils python3 python3-venv ffmpeg libsm6 libxext6
CMD ["bash"]
COPY entrypoint.sh /app/entrypoint.sh # buildkit
USER sduser
WORKDIR /app
RUN /bin/sh -c git clone https://github.com/AUTOMATIC1111/stable-diffusion-webui stable-diffusion-webui # buildkit
VOLUME [/app/stable-diffusion-webui/extensions]
VOLUME [/app/stable-diffusion-webui/models]
VOLUME [/app/stable-diffusion-webui/outputs]
VOLUME [/app/stable-diffusion-webui/localizations]
EXPOSE map[8080/tcp:{}]
ENTRYPOINT ["/app/entrypoint.sh" "--update-check" "--xformers" "--listen" "--port" "8080"]


