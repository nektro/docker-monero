ARG version=v0.16.0.3
ARG file=monero-linux-x64-${version}.tar.bz2
ARG folder=monero-x86_64-linux-gnu-${version}

FROM debian:stable as stage1
ARG version
ARG file
ARG folder
WORKDIR /the/workdir
RUN apt update
RUN apt install -y wget bzip2
RUN wget https://downloads.getmonero.org/cli/${file}
RUN tar -vxf ${file}
RUN ls
RUN chmod +x /the/workdir/${folder}/monerod

FROM photon
ARG folder
COPY --from=stage1 /the/workdir/${folder}/monerod /app/monerod
VOLUME /data
EXPOSE 18081
ENTRYPOINT /app/monerod --prune-blockchain --data-dir="/data" --rpc-bind-port="18081" --rpc-login="monero:password"
