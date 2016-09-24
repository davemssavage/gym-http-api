FROM ubuntu:16.04

WORKDIR /home

# install pip3
RUN apt-get update -y && apt-get install -y python3-setuptools python3-dev build-essential

RUN apt-get install -y ca-certificates

RUN easy_install3 pip

# install dependencies of the Gym
RUN apt-get install -y gcc g++ python3-numpy python3-dev  cmake zlib1g-dev libjpeg-dev xvfb libav-tools xorg-dev python3-opengl

# box-2d dependency
RUN apt-get install -y swig

# install git
RUN apt-get install -y git

# install nose2 for python test
RUN pip3 install nose2

# pyglet for classic control
RUN pip3 install pyglet

# install OpenAI Gym (all, exclude MuJoCo)
RUN git clone https://github.com/davemssavage/gym.git && pip3 install -e './gym[all]'

RUN git clone https://github.com/davemssavage/gym-http-api && cd gym-http-api && git checkout bind-address && pip install -r requirements.txt

RUN apt-get install -y ffmpeg

RUN rm -rf /var/lib/apt

EXPOSE 5000

CMD xvfb-run -s "-screen 0 1400x900x24" python3 -u gym-http-api/gym_http_server.py --listen 0.0.0.0
