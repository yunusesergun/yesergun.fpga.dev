# Use the official Ubuntu 22.04 as the base image
FROM ubuntu:22.04

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive

# Update the package list and install necessary dependencies
RUN apt-get update && \
    apt-get install -y \
    build-essential \
    libncurses5-dev \
    libncursesw5-dev \
    libtinfo5 \
    libx11-6 \
    libxrender1 \
    libxtst6 \
    libxi6 \
    libglib2.0-0 \
    libsm6 \
    libpng-dev \
    libgtk2.0-0 \
    libcanberra-gtk-module \
    libcanberra-gtk3-module \
    xauth \
    xfonts-base \
    xfonts-100dpi \
    xfonts-75dpi \
    xfonts-cyrillic \
    libfreetype6-dev \
    libfontconfig1-dev \
    curl \
    unzip \
    python3-pip \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install gdown to download files from Google Drive
RUN pip3 install gdown

# Download and install Vivado
RUN gdown --fuzzy https://drive.google.com/file/d/1lU5Z8eaOu_eicJbNJSsuqwIb2a7_D8JU/view?usp=sharing -O Xilinx_Unified_2022.1_0420_0327_Lin64.bin
RUN chmod +x Xilinx_Unified_2022.1_0420_0327_Lin64.bin

# Add a debug step to check if the file is present
RUN ls -lh Xilinx_Unified_2022.1_0420_0327_Lin64.bin

# Run the Vivado installer in silent mode
RUN ./Xilinx_Unified_2022.1_0420_0327_Lin64.bin --confirm -- -y --noexec --target /opt || { echo "Vivado installation failed"; exit 1; }

# Check if Vivado is installed correctly
RUN ls -lah /opt/Xilinx

# Add Vivado to PATH
ENV PATH="/opt/Xilinx/Vivado/2022.1/bin:${PATH}"

# Set default command
CMD ["bash"]
