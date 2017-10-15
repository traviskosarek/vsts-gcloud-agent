FROM microsoft/vsts-agent:latest

LABEL maintainer="Travis Kosarek <travis.kosarek@gmail.com>" \
      description="This is a child image to extend support to Google Cloud SDK within the running VSTS Build Agent container"

# Enable HTTPS connections (must be before calls to https)
RUN apt-get update && apt-get -y --no-install-recommends install apt-transport-https

# Add the Cloud SDK distribution URI as a package source
RUN echo "deb https://packages.cloud.google.com/apt cloud-sdk-$(lsb_release -c -s) main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list

# Import the Google Cloud Platform public key
RUN curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -

# Update the package list and install the Cloud SDK
RUN apt-get update && apt-get -y --no-install-recommends install google-cloud-sdk