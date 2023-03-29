# Use the official Python base image
FROM python:3.9-slim-buster

# Install necessary system packages
RUN apt-get update && \
    apt-get install -y build-essential libreadline-dev libncurses-dev libx11-dev libxt-dev libxtst-dev libcairo2-dev libtiff5-dev libjpeg62-turbo-dev libgtk2.0-dev libxext-dev libxmu-dev libxi-dev libsqlite3-dev libpcre3-dev libmotif-dev libdbus-1-dev libglib2.0-dev libgtk-3-dev libwxgtk3.0-gtk3-dev wget && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install EPICS base and synApps
ENV EPICS_ROOT=/epics
RUN mkdir -p ${EPICS_ROOT}
WORKDIR ${EPICS_ROOT}
COPY install-epics.sh .
RUN chmod +x install-epics.sh
RUN ./install-epics.sh

# Set EPICS environment variables
ENV EPICS_BASE=${EPICS_ROOT}/base
ENV PATH=${EPICS_BASE}/bin/linux-x86_64:${PATH}
ENV LD_LIBRARY_PATH=${EPICS_BASE}/lib/linux-x86_64:${LD_LIBRARY_PATH}

# Install Python libraries
RUN pip install pyepics PyQt5 numpy

# Set up the working directory for your applications
WORKDIR /app

# Copy your application files into the container
COPY . /app

# Set up the entrypoint
CMD ["python", "your_application.py"]
