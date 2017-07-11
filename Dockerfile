FROM mjmg/centos-mro-rstudio-opencpu-shiny-server

RUN \
  yum install -y openblas-devel lapack-devel cairo-devel libXt-devel opencv-devel

RUN \
  cd /tmp && \
  git clone --recursive https://github.com/dmlc/mxnet

RUN \
  cd mxnet && \
  make USE_OPENCV=1 USE_BLAS=openblas ADD_CFLAGS='-I/usr/include/openblas/'

RUN \
  cd /tmp/mxnet/ && \
  make rpkg && \
  R CMD INSTALL mxnet_current_r.tar.gz

ADD \
  test-mxnet.R /tmp/test-mxnet.R

# Test MXnet on docker host
RUN \
  Rscript -e "source('test-mxnet.R")"
# Define default command.
CMD ["/usr/bin/supervisord","-c","/etc/supervisor/supervisord.conf"]
