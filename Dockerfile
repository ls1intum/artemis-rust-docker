FROM rust:1.78

RUN apt-get update && apt-get install -y --no-install-recommends \
  jq \
  && rm -rf /var/lib/apt/lists/*

# cargo clippy
RUN rustup component add clippy

# cargo nextest
RUN curl -LsSf https://get.nexte.st/0.9.70/linux | tar zxf - -C ${CARGO_HOME:-~/.cargo}/bin

# clippy-sarif
RUN cargo install --locked clippy-sarif@0.7.0

# sccache
RUN cargo install --locked --no-default-features sccache@0.10.0
ENV RUSTC_WRAPPER=sccache

WORKDIR /usr/src/artemis-test
ENV CARGO_INCREMENTAL=false

# build and cache common dependencies
COPY test .
RUN cargo build --tests --profile test && find . -delete

ENV SCCACHE_LOCAL_RW_MODE=READ_ONLY
