# Use a minimal base image
FROM ubuntu:20.04

# Set the DEBIAN_FRONTEND environment variable to noninteractive
ENV DEBIAN_FRONTEND=noninteractive

# Set the working directory
WORKDIR /app

# Install required packages
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    libicu66 inkscape ca-certificates wget && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Create pwsh directory
RUN mkdir -p /usr/local/bin/pwsh

# Install pwsh
RUN wget https://github.com/PowerShell/PowerShell/releases/download/v7.2.13/powershell-7.2.13-linux-arm64.tar.gz && \
    tar -xzf powershell-7.2.13-linux-arm64.tar.gz -C /usr/local/bin/pwsh/ --strip-components=1 && \
    chmod +x /usr/local/bin/pwsh && \
    rm powershell-7.2.13-linux-arm64.tar.gz

# Update PATH
ENV PATH="/usr/local/bin/pwsh:$PATH"

# Copy run.ps1 to the container
COPY run.ps1 /app/

# Set the command to run when the container starts
CMD ["pwsh", "-File", "run.ps1"]
