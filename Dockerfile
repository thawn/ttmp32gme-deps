FROM perl:slim

COPY --from=johannesfritsch/tttool /usr/local/bin/tttool /usr/local/bin
COPY ffmpeg/ffmpeg /usr/local/bin

ARG build_deps='gcc apt-utils'

RUN set -x \
  && apt-get update && apt-get install -y --no-install-recommends $build_deps \
    libc6-dev \
    libxml2-dev \
    zlib1g-dev \
    libgmp-dev \
  && cpan -T -i \
    EV \
    AnyEvent::HTTPD \
    Path::Class \
    Cwd \
    File::Basename \
    File::Find \
    List::MoreUtils \
    PAR \
    Encode \
    Text::Template \
    JSON::XS \
    URI::Escape \
    Getopt::Long \
    Perl::Version \
    DBI \
    DBIx::MultiStatementDo \
    Log::Message::Simple \
    Music::Tag::MP3 \
    Music::Tag::OGG \
    Music::Tag::MusicBrainz \
    Music::Tag::Auto \
    MP3::Tag \
    Image::Info \
    WebService::MusicBrainz::Artist \
    Locale::Country \
    Locale::Codes \
  && apt-get purge -y --auto-remove $build_deps \
  && rm -rf /var/lib/apt/lists/*
