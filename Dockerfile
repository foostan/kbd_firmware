FROM ghcr.io/qmk/qmk_cli:latest
RUN git config --global --add safe.directory /project 
RUN git config --global --add safe.directory /project/src/vial-kb/vial-qmk
RUN git config --global --add safe.directory /project/src/qmk/qmk_firmware
