# Imagem base do Binder com R
FROM rocker/binder:4.4.2

# Metadados
LABEL maintainer="Pablo Rogers <pablorogers@ufu.br>" \
      description="MyBinder environment for ARTE"

# Configuração do renv
ENV RENV_PATHS_CACHE=/home/rstudio/renv/cache
ENV RENV_PATHS_LIBRARY=/home/rstudio/renv/library

# Copiar arquivos do renv para o container
COPY --chown=rstudio renv.lock /home/rstudio/renv.lock
COPY --chown=rstudio .Rprofile /home/rstudio/.Rprofile
COPY --chown=rstudio renv/activate.R /home/rstudio/renv/activate.R

# Copiar o resto do projeto
COPY --chown=rstudio . /home/rstudio

# Restaurar pacotes R via renv
RUN R -s -e "renv::restore()"

RUN quarto install tinytex