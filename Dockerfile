FROM mcr.microsoft.com/dotnet/sdk:3.1-focal
WORKDIR /actions-runner

ARG RUNNER_VERSION=2.277.1

RUN DEBIAN_FRONTEND=noninteractive apt update && \
  DEBIAN_FRONTEND=noninteractive apt install -y \
  curl \
  inetutils-ping \
  coreutils \
  ca-certificates \
  unattended-upgrades && \
  apt-get autoremove -y && \
  rm -rf /var/lib/apt/lists/*

RUN groupadd -g 999 runner && useradd -r -u 999 -g runner runner
RUN chown runner:runner /actions-runner

COPY ./start.sh .
RUN chmod a+x ./start.sh
RUN chown runner:runner ./start.sh

USER runner


RUN curl -O -L https://github.com/actions/runner/releases/download/v${RUNNER_VERSION}/actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz
RUN tar xzf ./actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz

ENV URL= TOKEN=
CMD ["./start.sh"]
