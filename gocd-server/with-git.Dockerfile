FROM my-gocd-server

RUN apt-get update && apt-get install -y --no-install-recommends \
     git \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*
