FROM alpine:latest AS po4a-builder

ARG PO4A_VERSION=0.73
ENV PO4A_GH_URL=https://github.com/mquinson/po4a/releases/download

RUN apk add --no-cache wget
RUN wget --quiet ${PO4A_GH_URL}/v${PO4A_VERSION}/po4a-${PO4A_VERSION}.tar.gz
RUN mkdir -p /po4a
RUN tar -xf po4a-${PO4A_VERSION}.tar.gz -C /po4a --strip-components=1
RUN rm po4a-${PO4A_VERSION}.tar.gz
RUN apk del --purge wget

FROM alpine:latest

ENV PATH="/opt/po4a:${PATH}" \
    PERL5LIB="/opt/po4a/lib"

COPY --from=po4a-builder /po4a /opt/po4a

RUN apk --no-cache add \
    bash \
    gettext \
    gettext-dev \
    opensp \
    perl \
    perl-dev \
    perl-unicode-linebreak \
    perl-yaml \
    && apk add --no-cache --virtual .build-deps \
        build-base \
        perl-app-cpanminus \
    && wget -q https://cpan.metacpan.org/authors/id/R/RA/RAAB/SGMLSpm-1.1.tar.gz \
    && tar -xzf SGMLSpm-1.1.tar.gz \
    && cd SGMLSpm-1.1 \
    && perl Makefile.PL \
    && make install \
    && cd .. \
    && rm -rf SGMLSpm-1.1 SGMLSpm-1.1.tar.gz \
    && CFLAGS="-I/usr/include" LIBS="-L/usr/lib -lintl" cpanm --no-wget Locale::gettext \
    && cpanm --no-wget Text::WrapI18N \
    && cpanm --no-wget Term::ReadKey \
    && cpanm --no-wget Pod::Parser \
    && cpanm --no-wget YAML::Tiny \
    && cpanm --no-wget Unicode::GCString \
    && cpanm --no-wget Syntax::Keyword::Try \
    && cpanm --no-wget Encode::Locale \
    && apk del .build-deps \
    && rm -rf /var/cache/apk/* /var/tmp/* /root/.cpanm \
    && addgroup -g 121 runner \
    && adduser -u 1001 -G runner -s /bin/bash -D runner

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

USER runner
WORKDIR /data
ENTRYPOINT ["/entrypoint.sh"]
