FROM perl:slim

COPY --from=johannesfritsch/tttool /usr/local/bin/tttool /usr/local/bin

RUN build-deps='gcc apt-utils' \
  && set -x \
  && apt-get update && apt-get install -y $buildDeps --no-install-recommends \
    apt-get install -y \
    libc6-dev \
    libxml2-dev \
    zlib1g-dev \
    ffmpeg \
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
  && apt-get purge -y --auto-remove $buildDeps \
  && rm -rf /var/lib/apt/lists/*
