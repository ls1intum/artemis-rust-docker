FROM rust:1.78

RUN apt-get update && apt-get install -y --no-install-recommends \
  jq \
  && rm -rf /var/lib/apt/lists/*

# cargo clippy
RUN rustup component add clippy

# cargo nextest
RUN curl -LsSf https://get.nexte.st/0.9.70/linux | tar zxf - -C ${CARGO_HOME:-~/.cargo}/bin

# clippy-sarif
RUN cargo install clippy-sarif@0.7.0
