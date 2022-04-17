FROM docker.io/debian:bullseye-slim

WORKDIR /var/local

# combine into one run command to reduce image size
RUN apt-get update && apt-get install -y perl entr wget libfontconfig1 && \
    wget -qO- "https://yihui.org/tinytex/install-bin-unix.sh" | sh && \
    apt-get clean

ENV PATH="${PATH}:/root/bin"

RUN tlmgr install xetex
RUN fmtutil-sys --all

RUN tlmgr install pgf fancyhdr parskip babel-english units lastpage comment fontawesome babel-french numprint hyphenat glossaries caption endnotes enumitem wrapfig pdfpages listings carlisle mfirstuc textcase xfor datatool tracklang appendix pdflscape glossaries-french babel-french

WORKDIR /data/
