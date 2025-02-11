FROM rust:1.78

# cargo clippy
RUN rustup component add clippy

# cargo nextest
RUN curl -LsSf https://get.nexte.st/0.9.70/linux | tar zxf - -C ${CARGO_HOME:-~/.cargo}/bin

# clippy-sarif
RUN cargo install clippy-sarif@0.7.0
