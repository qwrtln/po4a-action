FROM alpine:3.18 AS builder

ARG PO4A_VERSION
ENV PO4A_GH_URL=https://github.com/mquinson/po4a/releases/download

RUN apk add --no-cache wget && \
    wget --quiet ${PO4A_GH_URL}/v${PO4A_VERSION}/po4a-${PO4A_VERSION}.tar.gz && \
    tar -xf po4a-${PO4A_VERSION}.tar.gz && \
    rm po4a-${PO4A_VERSION}.tar.gz

FROM perl:5.40-slim

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      gettext \
      libyaml-tiny-perl \
      libextutils-cbuilder-perl \
      libextutils-parsexs-perl \
      build-essential \
      liblocale-gettext-perl \
      libtext-wrapi18n-perl \
      libterm-readkey-perl \
      libsgmls-perl \
      opensp \
      docbook \
      libunicode-linebreak-perl \
      && \
    cpanm Module::Build && \
    cpanm ExtUtils::CChecker && \
    cpanm XS::Parse::Keyword && \
    cpanm Syntax::Keyword::Try && \
    cpanm YAML::Tiny && \
    cpanm Unicode::GCString && \
    apt-get remove -y \
      build-essential \
      libextutils-cbuilder-perl \
      libextutils-parsexs-perl \
      && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* ~/.cpanm

COPY --from=builder /po4a-* /opt/po4a/
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
