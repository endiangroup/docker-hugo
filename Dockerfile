FROM deis/go-dev

RUN apt-get update
RUN apt-get install -y libcairo2-dev libjpeg-dev libgif-dev pkg-config

# Ruby
RUN apt-get install -y ruby ruby-dev ruby-bundler curl apt-utils -y
RUN gem install sass --no-user-install
RUN gem install mime-types:2.0 rake cucumber capybara selenium-webdriver rspec browserstack-local parallel_tests
RUN gem install toml-rb

# Hugo
ENV HUGO_VERSION=0.55.5
ADD https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_extended_${HUGO_VERSION}_Linux-64bit.tar.gz /tmp
RUN tar -xf /tmp/hugo_extended_${HUGO_VERSION}_Linux-64bit.tar.gz -C /tmp \
    && mkdir -p /usr/local/sbin \
    && mv /tmp/hugo /usr/local/sbin/hugo \
    && rm -rf /tmp/hugo_${HUGO_VERSION}_linux_amd64

# Node.JS
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash
RUN apt-get install nodejs -y

# Yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update && apt-get install yarn

# Typescript
RUN npm install -g typescript 

# Fontcustom
RUN apt-get install zlib1g-dev fontforge -y
RUN git clone https://github.com/bramstein/sfnt2woff-zopfli.git sfnt2woff-zopfli && cd sfnt2woff-zopfli && make && mv sfnt2woff-zopfli /usr/local/bin/sfnt2woff
RUN git clone --recursive https://github.com/google/woff2.git && cd woff2 && make clean all && mv woff2_compress /usr/local/bin/ && mv woff2_decompress /usr/local/bin/
RUN gem install --no-document fontcustom

# Set up the workspace
RUN mkdir -p /hugo
WORKDIR /hugo
